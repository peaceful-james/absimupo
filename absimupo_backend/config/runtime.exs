import Config

ensure_command_in_path = fn command ->
  try do
    System.cmd(command, [])
  catch
    :error, :enoent ->
      raise("command #{command} does not exist in the PATH of the current system.")
  end
end

get_env_var_value = fn
  atom_name, non_prod_default ->
    env_var_name = atom_name |> to_string() |> String.upcase()
    default_value = if config_env() in [:prod], do: nil, else: non_prod_default
    value = System.get_env(env_var_name, default_value)

    if is_nil(value) and config_env() in [:prod],
      do: raise("environment variable #{env_var_name} is missing."),
      else: value
end

get_env_var_value_with_prod_default = fn
  atom_name, default_value ->
    env_var_name = atom_name |> to_string() |> String.upcase()
    System.get_env(env_var_name, default_value)
end

set_config = fn
  atom_name, non_prod_default ->
    value = get_env_var_value.(atom_name, non_prod_default)
    config(:absimupo, atom_name, value)
end

host = get_env_var_value.(:host, "localhost")

origins = get_env_var_value.(:allowed_origins, "") |> String.split()

case config_env() do
  :dev ->
    config(:cors_plug, origin: ~r/https?:\/\/localhost:\d*$/)

  _ ->
    config(:cors_plug, origin: origins)
end

# Ensure the imagemagick command "identify" is on the system (raises if not).
ensure_command_in_path.("identify")

config :imgproxy,
  prefix: get_env_var_value.(:imgproxy_prefix, "http://localhost:4007"),
  key: get_env_var_value.(:imgproxy_key, nil),
  salt: get_env_var_value.(:imgproxy_salt, nil)

imgproxy_max_src_resolution = get_env_var_value.(:imgproxy_max_src_resolution, "16.8")
config(:absimupo, :imgproxy_max_src_resolution, imgproxy_max_src_resolution)

config(
  :absimupo,
  :imgproxy_max_src_resolution_true,
  imgproxy_max_src_resolution |> Decimal.new() |> Decimal.mult(1_000_000) |> Decimal.to_integer()
)

set_config.(:backblaze_bucket_name, "absimupo-images")
set_config.(:backblaze_b2_api_version, "2")
set_config.(:backblaze_b2_auth_url, "https://api.backblazeb2.com/b2api/v2/")
backblaze_b2_id = get_env_var_value.(:backblaze_b2_id, nil)
backblaze_b2_key = get_env_var_value.(:backblaze_b2_key, nil)

config(:absimupo,
  backblaze_b2_basic_auth: "Basic " <> Base.encode64("#{backblaze_b2_id}:#{backblaze_b2_key}")
)

# Here follows config for gigalixir release
if config_env() in [:prod] do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """

  config :absimupo, Absimupo.Repo,
    # ssl: true,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "2")

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  config :absimupo, AbsimupoWeb.Endpoint,
    server: true,
    http: [
      port: String.to_integer(System.get_env("PORT") || "4001"),
      transport_options: [socket_opts: [:inet6]]
    ],
    url: [host: host],
    check_origin: origins,
    secret_key_base: secret_key_base
end
