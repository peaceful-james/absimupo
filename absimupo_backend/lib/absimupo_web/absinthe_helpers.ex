defmodule AbsimupoWeb.AbsintheHelpers do
  def get_via_dataloader(loader, assoc_field, parent) do
    loader
    |> Dataloader.load(:data, assoc_field, parent)
    |> Dataloader.run()
    |> Dataloader.get(:data, assoc_field, parent)
  end

  def to_global_id(node_object_type, local_id) do
    Absinthe.Relay.Node.to_global_id(node_object_type, local_id, AbsimupoWeb.Schema)
  end

  def to_local_id(global_id) do
    case Absinthe.Relay.Node.from_global_id(global_id, AbsimupoWeb.Schema) do
      {:ok, %{type: _type, id: local_id}} -> local_id
      _ -> nil
    end
  end
end
