defmodule AbsimupoWeb.Schema.Middleware.ChangesetErrors do
  @behaviour Absinthe.Middleware

  alias AbsimupoWeb.ErrorHelpers

  @doc """
  Moves changeset errors from the :errors property to the :value property.
  This prevents them "bubbling up", in ways we might have to control.
  It particularly is a safeguard against the user seeing them.
  """
  def call(res, _) do
    case res do
      %{errors: [%Ecto.Changeset{} = changeset]} ->
        %{res | value: %{errors: transform_errors(changeset)}, errors: []}

      _ ->
        res
    end
  end

  defp transform_errors(changeset) do
    changeset
    |> ErrorHelpers.error_codes()
    |> Enum.map(fn
      {key, value} ->
        %{key: key, message: value}
    end)
  end
end
