defmodule Absimupo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Absimupo.Repo,
      # Start the Telemetry supervisor
      AbsimupoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Absimupo.PubSub},
      # Authorize with Backblaze B2 and refresh config
      Absimupo.Backblaze.B2Sync,
      # Start the Endpoint (http/https)
      AbsimupoWeb.Endpoint,
      # Start the Absinthe Subscription
      {Absinthe.Subscription, AbsimupoWeb.Endpoint}
      # Start a worker by calling: Absimupo.Worker.start_link(arg)
      # {Absimupo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Absimupo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AbsimupoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
