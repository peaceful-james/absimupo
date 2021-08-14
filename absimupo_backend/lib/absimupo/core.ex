defmodule Absimupo.Core do
  @moduledoc """
  The Core context.
  """
  alias Absimupo.ImagePersistence

  import Ecto.Query, warn: false
  alias Absimupo.Repo

  alias Absimupo.Core.Thing

  @doc """
  Returns the list of things.

  ## Examples

      iex> list_things()
      [%Thing{}, ...]

  """
  def list_things do
    Repo.all(Thing)
  end

  @doc """
  Gets a single thing.

  Raises `Ecto.NoResultsError` if the Thing does not exist.

  ## Examples

      iex> get_thing!(123)
      %Thing{}

      iex> get_thing!(456)
      ** (Ecto.NoResultsError)

  """
  def get_thing!(id), do: Repo.get!(Thing, id)

  @doc """
  Creates a thing.

  ## Examples

      iex> create_thing(%{field: value})
      {:ok, %Thing{}}

      iex> create_thing(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_thing(attrs \\ %{}) do
    %Thing{}
    |> Thing.changeset(attrs)
    |> Repo.insert()
  end

  defp create_thing(_effects_so_far, %{thing: attrs}) do
    create_thing(attrs)
  end

  @doc """
  Creates a thing with a logo
  """
  def create_thing_with_logo(%{thing: _thing, logo: _logo} = attrs) do
    case Sage.new()
         |> Sage.run(:thing, &create_thing/2)
         |> Sage.run(:logo, &ImagePersistence.upload_logo/2)
         |> Sage.transaction(Absimupo.Repo, attrs) do
      {:ok, _last_effect, %{thing: thing}} -> {:ok, %{thing: thing}}
      anything -> anything
    end
  end

  @doc """
  Updates a thing.

  ## Examples

      iex> update_thing(thing, %{field: new_value})
      {:ok, %Thing{}}

      iex> update_thing(thing, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_thing(%Thing{} = thing, attrs) do
    thing
    |> Thing.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a thing.

  ## Examples

      iex> delete_thing(thing)
      {:ok, %Thing{}}

      iex> delete_thing(thing)
      {:error, %Ecto.Changeset{}}

  """
  def delete_thing(%Thing{} = thing) do
    Repo.delete(thing)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking thing changes.

  ## Examples

      iex> change_thing(thing)
      %Ecto.Changeset{data: %Thing{}}

  """
  def change_thing(%Thing{} = thing, attrs \\ %{}) do
    Thing.changeset(thing, attrs)
  end
end
