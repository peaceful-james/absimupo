defmodule Absimupo.Backblaze.B2Service do
  @moduledoc """
  Provides a consistent low-level interface with the B2 API,
  using the Quest pattern.
  """
  alias Absimupo.Backblaze.MockedB2Service
  alias Absimupo.Quest

  @type dispatch_result :: {:ok, {scode :: integer(), any()}} | {:error, any()}

  defp default_q,
    do: %Quest{
      dispatcher: Quest.HTTPoisonDispatcher,
      headers: [
        {"Authorization", Application.get_env(:absimupo, :backblaze_b2_authorization_token)}
      ],
      params: %{},
      verb: :post,
      base_url: Application.get_env(:absimupo, :backblaze_b2_base_url),
      destiny: "b2",
      adapter_options: [recv_timeout: 20_000]
    }

  defp maybe_mock_dispatcher do
    if Mix.env() in [:dev, :test] and is_nil(System.get_env("USE_REAL_BACKBLAZE_B2")) do
      [dispatcher: MockedB2Service.mocked_dispatcher()]
    else
      []
    end
  end

  @doc """
  Creates a configurable B2 Quest struct
  """
  @spec client([term()]) :: %Quest{}
  def client(client_opts \\ []) do
    maybe_mock_dispatcher()
    |> Keyword.merge(client_opts)
    |> Enum.into(default_q())
  end

  @doc """
  Sends a HTTP request using the given B2 Quest struct
  """
  @spec http_req(any(), [term()]) :: dispatch_result()
  def http_req(req, options) do
    options
    |> Enum.into(req)
    |> Quest.dispatch()
  end

  @doc """
  Sends a HTTP request using the default B2 Quest struct
  """
  @spec default_http_req([{atom(), term()}]) :: dispatch_result()
  def default_http_req(options), do: client() |> http_req(options)

  @doc """
  Authorizes with the B2 API.
  """
  @spec authorize_account() :: dispatch_result()
  def authorize_account do
    [
      base_url: Application.get_env(:absimupo, :backblaze_b2_auth_url),
      headers: [{"Authorization", Application.get_env(:absimupo, :backblaze_b2_basic_auth)}]
    ]
    |> client()
    |> http_req(path: "b2_authorize_account", payload: %{})
  end

  @doc """
  Lists all B2 buckets
  """
  @spec list_buckets() :: dispatch_result()
  def list_buckets do
    default_http_req(
      path: "b2_list_buckets",
      payload: %{
        accountId: Application.get_env(:absimupo, :backblaze_b2_account_id),
        bucketId: Application.get_env(:absimupo, :backblaze_b2_bucket_id)
      }
    )
  end

  @doc """
  Gets the URL where we upload files to B2
  """
  @spec get_upload_url() :: dispatch_result()
  def get_upload_url do
    default_http_req(
      path: "b2_get_upload_url",
      payload: %{
        bucketId: Application.get_env(:absimupo, :backblaze_b2_bucket_id)
      }
    )
  end

  @doc """
  Uploads the given payload to B2 with given file_name
  In the happy path, returns something like:
  {:ok,
    {200,
      %{
        "accountId" => "xxx",
        "action" => "upload",
        "bucketId" => "xxx",
        "contentLength" => 75706,
        "contentMd5" => "xxx",
        "contentSha1" => "xxx",
        "contentType" => "image/png",
        "fileId" => "xxx",
        "fileInfo" => %{},
        "fileName" => "img1.png",
        "fileRetention" => %{"isClientAuthorizedToRead" => false, "value" => nil},
        "legalHold" => %{"isClientAuthorizedToRead" => false, "value" => nil},
        "serverSideEncryption" => %{"algorithm" => nil, "mode" => nil},
        "uploadTimestamp" => 1621870591000
  }}}
  """
  @spec upload_file(binary(), binary(), binary()) :: dispatch_result()
  def upload_file(payload, file_name, content_type) do
    x_bz_file_name = URI.encode(file_name)
    checksum = :crypto.hash(:sha, payload) |> Base.encode16()
    # content_length = byte_size(checksum) + byte_size(payload)
    content_length = byte_size(payload)

    [
      request_encoding: nil,
      base_url: Application.get_env(:absimupo, :backblaze_b2_upload_url),
      headers: [
        {"Authorization", Application.get_env(:absimupo, :backblaze_b2_upload_token, "")},
        {"X-Bz-File-Name", x_bz_file_name},
        {"Content-Type", content_type},
        {"Content-Length", content_length},
        {"X-Bz-Content-Sha1", checksum}
      ]
    ]
    |> client()
    |> http_req(
      path: "",
      payload: payload
    )
  end
end
