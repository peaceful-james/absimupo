defmodule AbsimupoWeb.Resolvers.Core.Thing do
  alias Absimupo.Core

  def list_things(_, args, _resolution) do
    Absinthe.Relay.Connection.from_query(
      Absimupo.Core.Thing,
      &Absimupo.Repo.all/1,
      args
    )
  end

  def get_thing(%{errors: _errors}, _args, _resolution) do
    {:ok, nil}
  end

  def get_thing(%{thing: thing}, _args, _resolution) do
    Absinthe.Relay.Connection.from_list([thing], %{first: 1})
  end

  def create_thing_with_logo(_, %{input: params}, _resolution) do
    {logo, params} = Map.pop(params, :logo)
    attrs = %{thing: params, logo: logo}
    Core.create_thing_with_logo(attrs)
  end
end
