defmodule Absimupo.Quest.HTTPoisonDispatcher do
  @moduledoc """
  A modified Quest request dispatcher, based off the default,
  which @gvaughn describes as "rather pedestrian".
  """
  require Logger
  alias Absimupo.Quest
  alias AbsimupoWeb.UriQuery
  alias HTTPoison.Response

  @type status_code :: integer()
  @type response :: map()
  @type dispatch_result ::
          {:ok, %{}}
          | {:ok, {status_code(), response()}}
          | {:ok, :no_content}
          | {:error, {status_code(), map()}}
          | {:error, {:json, {status_code(), term()}}}
          | {:error, {binary(), %HTTPoison.Error{}}}
          | {:error, {:unknown, response()}}

  @success_status_codes [200, 201]

  @doc """
  Dispatches a %Quest{} and handles the response
  """
  @spec dispatch(%Quest{}) :: dispatch_result()
  def dispatch(q) do
    url = URI.merge(q.base_url, q.path) |> URI.to_string()
    options = [{:params, q.params} | q.adapter_options]

    true_headers = q.headers ++ q.extra_headers

    case HTTPoison.request(q.verb, url, encode_payload(q), true_headers, options)
         |> handle_response(q.response_encoding) do
      {:error, _anything} = error ->
        Logger.error("Got Quest dispatch error for url #{url} #{inspect(error, pretty: true)}")
        error

      anything_else ->
        anything_else
    end
  end

  defp encode_payload(%{request_encoding: :json, verb: verb, payload: payload})
       when verb in [:post, :put],
       do: Jason.encode!(payload)

  defp encode_payload(%{request_encoding: :json, verb: :get, payload: %{}}), do: ""

  defp encode_payload(%{request_encoding: :urlencoded, payload: payload}) do
    payload |> UriQuery.params() |> URI.encode_query()
  end

  defp encode_payload(%{payload: payload}) do
    payload
  end

  # http success cases
  defp handle_response({:ok, %Response{body: body, status_code: scode}}, _response_encoding)
       when body in ["", nil] and scode in @success_status_codes do
    {:ok, %{}}
  end

  defp handle_response({:ok, %Response{body: body, status_code: scode} = _resp}, :raw)
       when scode in @success_status_codes do
    {:ok, {scode, body}}
  end

  defp handle_response({:ok, %Response{body: body, status_code: scode} = resp}, :json)
       when scode in @success_status_codes do
    case Jason.decode(body) do
      {:ok, resp} -> {:ok, {scode, resp}}
      {:error, _} -> {:error, {:json, {scode, resp}}}
    end
  end

  # http 204 success cases
  defp handle_response({:ok, %Response{status_code: 204}}, _response_encoding),
    do: {:ok, :no_content}

  # other http response code
  defp handle_response({:ok, %Response{status_code: scode, body: body}}, :json) do
    case Jason.decode(body) do
      {:ok, json} ->
        {:error, {scode, json}}

      # return unprocessed body
      _ ->
        {:error, {scode, body}}
    end
  end

  defp handle_response({:ok, %Response{status_code: scode, body: body}}, _response_encoding) do
    {:error, {scode, body}}
  end

  # httpoison error case
  defp handle_response({:error, %HTTPoison.Error{} = exp}, _response_encoding) do
    {:error, {Exception.message(exp), exp}}
  end

  # fallback case
  defp handle_response({_, response}, _response_encoding) do
    {:error, {:unknown, response}}
  end
end
