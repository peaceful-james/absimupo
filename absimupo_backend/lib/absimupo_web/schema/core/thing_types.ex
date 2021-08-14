defmodule AbsimupoWeb.Schema.Core.ThingTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  alias AbsimupoWeb.Resolvers.Core.Thing

  import_types(Absinthe.Plug.Types)

  connection(node_type: :thing)

  node object(:thing) do
    field :name, :string

    field :image_url_logo, :string do
      resolve(&Absimupo.ImagePersistence.resolver_url/2)
    end
  end

  input_object :thing_input do
    field(:name, non_null(:string))
    field(:logo, :upload)
  end

  object :thing_result do
    field(:errors, list_of(:input_error))

    connection field :thing, node_type: :thing do
      resolve(&Thing.get_thing/3)
    end
  end

  object :thing_queries do
    connection field :list_things, node_type: :thing do
      resolve(&Thing.list_things/3)
    end
  end

  object :thing_mutations do
    field :create_thing, :thing_result do
      arg(:input, non_null(:thing_input))
      resolve(&Thing.create_thing_with_logo/3)
    end
  end

  object :thing_subscriptions do
    connection field :thing_created, node_type: :thing do
      config(fn
        _args, _context ->
          {:ok, topic: "thing_created"}
      end)

      trigger(:create_thing,
        topic: fn
          %{thing: _thing} -> "thing_created"
        end
      )

      resolve(fn %{thing: thing}, _, _ ->
        Absinthe.Relay.Connection.from_list([thing], %{first: 1})
      end)
    end
  end
end
