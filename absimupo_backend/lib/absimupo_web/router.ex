defmodule AbsimupoWeb.Router do
  use AbsimupoWeb, :router

  require Absinthe.Plug

  pipeline :api do
    plug :accepts, ["json"]

    plug Plug.Parsers,
      parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
      pass: ["*/*"],
      json_decoder: Phoenix.json_library()
  end

  scope "/", Absinthe do
    pipe_through :api
    forward "/api", Plug, schema: AbsimupoWeb.Schema

    if Mix.env() in [:dev, :test] do
      forward "/",
              Plug.GraphiQL,
              schema: AbsimupoWeb.Schema,
              interface: :advanced,
              socket: AbsimupoWeb.UserSocket
    end
  end
end
