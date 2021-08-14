defmodule AbsimupoWeb.Schema.Middleware.ListErrors do
  @behaviour Absinthe.Middleware

  @doc """
  Moves "list" errors from the :errors property to the :value property.
  This prevents them "bubbling up", in ways we might have to control.
  It particularly is a safeguard against the user seeing them.
  """
  def call(res, _) do
    case res do
      %{errors: errors} when is_list(errors) ->
        if Enum.any?(errors) do
          error_messages =
            errors
            |> Enum.with_index()
            |> Enum.map(fn
              {message, index} when is_binary(message) ->
                %{key: "error #{index}", message: message}

              {map, index} when is_map(map) ->
                map
                |> Map.update(:key, "error #{index}", & &1)

              {kw, index} when is_list(kw) ->
                kw
                |> Keyword.put(:key, "error #{index}")
                |> Map.new()
            end)

          %{res | value: %{errors: error_messages}, errors: []}
        else
          res
        end

      _ ->
        res
    end
  end
end
