use Mix.Config

config :absimupo, env: :test

config :absimupo, Absimupo.Repo,
  username: System.get_env("ABSIMUPO_DB_USER", System.get_env("USER", "postgres")),
  password: System.get_env("ABSIMUPO_DB_PASSWORD", ""),
  database: "absimupo_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: System.get_env("ABSIMUPO_DB_HOSTNAME", "localhost"),
  pool: Ecto.Adapters.SQL.Sandbox,
  timeout: 200_000,
  ownership_timeout: 200_000

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :absimupo, AbsimupoWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
