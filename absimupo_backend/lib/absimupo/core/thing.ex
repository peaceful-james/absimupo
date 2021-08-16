defmodule Absimupo.Core.Thing do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "things" do
    field(:name, :string)

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

  @cut_off_datetime DateTime.new!(~D[2021-08-16], ~T[00:00:00])
  defp maybe_forbid(changeset) do
    if is_binary(System.get_env("FORBID_CREATING_THINGS")) do
      add_error(changeset, :name, "Nobody is allowed to create new things right now, sorry.")
    else
      if DateTime.compare(@cut_off_datetime, DateTime.utc_now()) == :lt do
        add_error(changeset, :name, "Nobody is allowed to create new things right now, sorry.")
      else
        changeset
      end
    end
  end
end
