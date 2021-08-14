defmodule AbsimupoWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern
  import Ecto.Query

  alias AbsimupoWeb.Schema.Middleware

  import_types(Absinthe.Phoenix.Types)

  import_types(__MODULE__.ImageUrlTypes)

  import_types(__MODULE__.Core.ThingTypes)

  node interface do
    resolve_type(fn
      anything, _ ->
        anything
    end)
  end

  @desc "An error encountered trying to perform the query/mutation"
  object :input_error do
    field :key, non_null(:string)
    field :message, non_null(:string)

    @desc """
    Error "status codes" which logically align with HTTP status codes.
    See https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#4xx_client_errors
    """
    field :status_code, :integer
  end

  def middleware(middleware, field, object) do
    middleware
    |> apply(:errors, field, object)
  end

  defp apply(middleware, :errors, _field, %{identifier: identifier})
       when identifier in [:mutation] do
    middleware ++ [Middleware.ChangesetErrors, Middleware.ListErrors]
  end

  defp apply(middleware, :errors, _field, _) do
    middleware
  end

  def data, do: Dataloader.Ecto.new(Absimupo.Repo, query: &data_query/2)

  def data_query(queryable, params) do
    preload = params[:preload] || []

    from q in queryable,
      preload: ^preload
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(:data, data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    import_fields(:thing_queries)
  end

  mutation do
    import_fields(:thing_mutations)
  end

  subscription do
    import_fields(:thing_subscriptions)
  end

  enum :sort_order do
    value(:asc)
    value(:desc)
  end
end
