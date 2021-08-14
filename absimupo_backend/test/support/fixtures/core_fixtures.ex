defmodule Absimupo.CoreFixtures do
  @moduledoc """
  Test helpers for creating entities via the Core context
  """

  def unique_thing_name, do: "thing-name-#{System.unique_integer()}"

  def thing_fixture(attrs \\ %{}) do
    case attrs |> Enum.into(%{name: unique_thing_name()}) |> Absimupo.Core.create_thing() do
      {:ok, thing} ->
        thing

      {:error, changeset} ->
        {:error, changeset}
    end
  end
end
