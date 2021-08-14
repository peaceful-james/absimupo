defmodule Absimupo.Backblaze do
  @moduledoc """
  The Backblaze module abstracts low-level BackblazeService functions.
  The Backblaze B2 service is used for persisting images.
  """
  alias Absimupo.Backblaze.B2Service
  require Logger

  defp proper_api_url(api_url),
    do: "#{api_url}/b2api/v#{Application.get_env(:absimupo, :backblaze_b2_api_version)}/"

  @doc """
  Authorizes with the B2 service, setting app env variables on success. 
  """
  @spec authorize_account() :: :ok | :error | {:error, binary()}
  def authorize_account do
    Logger.info("Authorizing with B2")

    case B2Service.authorize_account() do
      {:ok,
       {200,
        %{
          "accountId" => account_id,
          "allowed" => %{
            "bucketId" => bucket_id,
            "bucketName" => bucket_name
          },
          "apiUrl" => api_url,
          "authorizationToken" => authorization_token
        }}} ->
        Logger.info("Successfully authorized with B2")
        Application.put_env(:absimupo, :backblaze_b2_account_id, account_id)
        Application.put_env(:absimupo, :backblaze_b2_base_url, proper_api_url(api_url))
        Application.put_env(:absimupo, :backblaze_b2_bucket_id, bucket_id)
        Application.put_env(:absimupo, :backblaze_b2_bucket_name, bucket_name)
        Application.put_env(:absimupo, :backblaze_b2_authorization_token, authorization_token)
        :ok

      {:error, {_status_code, %{"message" => message}}} ->
        Logger.error("Could not authorize with B2: #{message}")
        {:error, message}

      _ ->
        Logger.error("Could not authorize with B2")
        :error
    end
  end

  @doc """
  Gets the URl where we upload images to B2, setting app env vars on success.
  """
  @spec get_upload_url() :: :ok | :error | {:error, binary()}
  def get_upload_url do
    Logger.info("Getting B2 upload URL")

    case B2Service.get_upload_url() do
      {:ok, {200, %{"uploadUrl" => upload_url, "authorizationToken" => authorization_token}}} ->
        Logger.info("Successfully got B2 upload URL")
        Application.put_env(:absimupo, :backblaze_b2_upload_url, upload_url)
        Application.put_env(:absimupo, :backblaze_b2_upload_token, authorization_token)
        :ok

      {:error, {_status_code, %{"message" => message}}} ->
        Logger.error("Could not get B2 upload URL: #{message}")
        {:error, message}

      _ ->
        Logger.error("Could not get B2 upload URL")
        :error
    end
  end

  @doc """
  Uploads a file to B2
  Example:
  iex> File.read!("~/img1.png") |> Absimupo.Backblaze.upload_file("img4.png", "image/png")
  :ok
  [debug] Successfully saved img4.png to B2
  """
  @spec upload_file(binary(), binary(), binary()) :: :ok | {:error, binary()}
  def upload_file(logo_path, file_name, content_type) do
    Logger.info("going to upload #{logo_path} to backblaze")
    verbose_image = logo_path |> Mogrify.identify()
    %{width: width, height: height} = verbose_image
    Logger.info("Image has width #{width} and height #{height}")

    with true <-
           height * width < Application.get_env(:absimupo, :imgproxy_max_src_resolution_true),
         {:ok, {200, %{}}} <-
           B2Service.upload_file(File.read!(logo_path), file_name, content_type) do
      Logger.debug("Successfully saved #{file_name} to B2")
      :ok
    else
      false ->
        {:error,
         "File resolution is too big! Should be less than #{Application.get_env(:absimupo, :imgproxy_max_src_resolution)} megapixels"}

      {:error, {_status_code, %{"message" => message}}} ->
        Logger.error("Could not save #{file_name} to B2: #{message}")
        {:error, "Could not save file."}

      _ ->
        Logger.error("Could not save #{file_name} to B2")
        {:error, "Encountered unknown error while saving file."}
    end
  end
end
