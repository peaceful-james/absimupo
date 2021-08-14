defmodule AbsimupoWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, _opts}) do
    msg
  end

  @spec error_codes(%Ecto.Changeset{}) :: [{atom(), binary()}]
  def error_codes(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn error ->
      translate_error(error)
    end)
    |> Enum.reduce(%{}, fn {key, value}, acc ->
      cond do
        Enum.all?(value, &is_map/1) -> Map.put(acc, key, Enum.map(value, &map_to_string/1))
        true -> Map.put(acc, key, value)
      end
    end)
  end

  defp map_to_string(map) do
    map
    |> Enum.map(fn {key, val} ->
      "#{key} #{val}"
    end)
    |> Enum.join(", ")
  end
end
