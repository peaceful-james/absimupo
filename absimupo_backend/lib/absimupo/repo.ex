defmodule Absimupo.Repo do
  use Ecto.Repo,
    otp_app: :absimupo,
    adapter: Ecto.Adapters.Postgres
end
