defmodule Absimupo.Imgproxy do
  require Logger
  alias Imgproxy, as: Im

  @dev_url "local:///"
  @prod_url "s3://"
  @default_opts [
    resize: :fit,
    width: 500,
    height: 500,
    gravity: :sm,
    enlarge: true,
    extension: nil
  ]

  def url(img_name, opts \\ [])
  def url(nil, _opts), do: nil

  def url(img_name, opts) do
    if prod_imgproxy_env?() do
      Im.url(
        @prod_url <> Application.get_env(:absimupo, :backblaze_bucket_name) <> "/" <> img_name,
        translate_opts(opts)
      )
    else
      Im.url(@dev_url <> img_name, translate_opts(opts))
    end
  end

  @doc """
  Gets the URL for the given "image_url" field.
  Image fields are expected to follow a convention where for
  an input object with field name, say, "logo",
  the queryable schema has corresponding field "image_url_logo".

  This function checks for and removes the "image_url_" suffix
  when creating the "name" for the url.

  An example "name" passed to url/2 would be:
  "thing/726f8093-4745-4f27-99ed-a53112f724aa/logo"
  """
  def resolver_url(_args, %{context: %{loader: _loader}} = resolution) do
    {:ok, resolution |> name() |> url()}
  end

  def name(resolution) do
    with true <- prod_imgproxy_env?(),
         parent <- resolution.definition.parent_type.identifier |> to_string(),
         parent_id <- resolution.source.id |> to_string(),
         source <- resolution.definition.schema_node.identifier |> to_string(),
         "image_url_" <> source_suffix <- source do
      name(parent, parent_id, source_suffix)
    else
      _ ->
        nil
    end
  end

  def name(parent, parent_id, source_suffix) do
    "#{parent}/#{parent_id}/#{source_suffix}"
  end

  defp prod_imgproxy_env? do
    Application.get_env(:absimupo, :env) == :prod or
      not is_nil(System.get_env("USE_REAL_IMGPROXY", nil))
  end

  defp translate_opts(opts) do
    @default_opts
    |> Keyword.merge(opts)
    |> Enum.map(fn
      {key, value} when is_atom(value) -> {key, to_string(value)}
      anything -> anything
    end)
  end

  def maybe_upload_logo(effects_so_far, %{logo: logo}) do
    if is_nil(logo) do
      {:ok, %{logo: nil}}
    else
      upload_logo(effects_so_far, %{logo: logo})
    end
  end

  def maybe_upload_logo(_, _) do
    {:ok, %{logo: nil}}
  end

  def upload_logo(%{thing: %{id: thing_id}}, %{logo: logo}) do
    upload_entity_logo(:thing, thing_id, logo)
  end

  def upload_logo(_, _) do
    {:error, "No logo provided"}
  end

  defp upload_entity_logo(entity_type, _entity_id, nil) do
    if Application.get_env(:absimupo, :env) in [:dev, :prod] do
      {:error, %{key: "logo", message: "No #{entity_type} logo provided"}}
    else
      {:ok, nil}
    end
  end

  defp upload_entity_logo(entity_type, entity_id, logo) do
    file_name = Absimupo.Imgproxy.name("#{entity_type}", entity_id, "logo")

    case Absimupo.Backblaze.upload_file(logo.path, file_name, logo.content_type) do
      :ok ->
        Logger.info("Saved #{entity_type} logo for #{entity_id} to backblaze.")
        {:ok, nil}

      {:error, message} ->
        Logger.warning("Problem saving #{entity_type} logo for #{entity_id} to backblaze.")
        {:error, message}
    end
  end
end
