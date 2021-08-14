defmodule Absimupo.Backblaze.MockedB2Service do
  @moduledoc """
  Mocks the B2 service, for quick development and local testing
  """
  require Logger
  alias Absimupo.Quest

  @doc """
  Accepts a B2 Quest struct and returns a mocked API response
  Unmocked paths result in a 500 response.
  """
  @spec mocked_dispatcher :: {:ok, {integer(), map()}} | {:error, {500, map()}}
  def mocked_dispatcher do
    fn
      %Quest{verb: :post, path: "b2_authorize_account", payload: %{}} ->
        {:ok,
         {200,
          %{
            "accountId" => "some-b2-account-id",
            "allowed" => %{
              "bucketId" => "some-b2-bucket-id",
              "bucketName" => "some-b2-bucket-name"
            },
            "apiUrl" => Application.get_env(:absimupo, :base_url),
            "authorizationToken" => "some-b2-authorization-token"
          }}}

      %Quest{verb: :post, path: "b2_get_upload_url", payload: %{}} ->
        {:ok, {200, %{"uploadUrl" => "", "authorizationToken" => ""}}}

      %Quest{verb: :post} ->
        {:ok, {200, %{}}}

      %Quest{path: path} ->
        Logger.error("No mocked response for B2 path #{path}")
        {:error, {500, %{"message" => "No mock response for this B2 path #{path}!"}}}
    end
  end
end
