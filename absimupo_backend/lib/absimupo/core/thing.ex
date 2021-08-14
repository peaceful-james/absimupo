defmodule Absimupo.Core.Thing do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "things" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(thing, attrs) do
    thing
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unsafe_validate_unique([:name], Absimupo.Repo)
    |> maybe_forbid()
  end

  defp maybe_forbid(changeset) do
    if System.get_env("FORBID_CREATING_THINGS") do
      add_error(changeset, :name, "Nobody is allowed to create new things right now, sorry.")
    else
      changeset
    end
  end
end
