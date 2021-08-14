# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :absimupo,
  ecto_repos: [Absimupo.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :absimupo, AbsimupoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SKrND++w0pUvN+WrhOYiohYw20g/mQmaIFKZlz7tQ6Asg2YrrkGdp2yeCxPAcW85",
  render_errors: [view: AbsimupoWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Absimupo.PubSub,
  live_view: [signing_salt: "rCJZ+5ne"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
