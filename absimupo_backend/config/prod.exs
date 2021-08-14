use Mix.Config

config :absimupo, env: :prod

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.
config :absimupo, AbsimupoWeb.Endpoint,
  # https://gigalixir.readthedocs.io/en/latest/domain.html?highlight=force_ssl#how-to-set-up-ssl-tls
  force_ssl: [
    rewrite_on: [:x_forwarded_proto],
    expires: 63_072_000,
    preload: true,
    host: nil,
    subdomains: true
  ],
  # Possibly not needed, but doesn't hurt
  http: [:inet6, port: System.get_env("PORT") || 4000],
  url: [scheme: "https", port: 443],
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE"),
  server: true

# Do not print debug messages in production
config :logger, level: :info

config :absimupo, Absimupo.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  ssl: true,
  queue_target: 5000,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "2")
