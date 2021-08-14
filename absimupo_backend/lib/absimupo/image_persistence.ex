defmodule Absimupo.ImagePersistence do
  @moduledoc """
  A simple module to determine how images should be persisted
  """
  alias Absimupo.Imgproxy

  def resolver_url(args, resolution) do
    case Application.get_env(:absimupo, :env) do
      :prod ->
        Imgproxy.resolver_url(args, resolution)

      _ ->
        {:ok, local_name(resolution)}
    end
  end

  def upload_logo(args, resolution) do
    case Application.get_env(:absimupo, :env) do
      :prod -> Imgproxy.upload_logo(args, resolution)
      _ -> persist_locally(args, resolution)
    end
  end

  defp local_name(resolution) do
    # This is pretty dumb but it's only for local dev so whatever
    "http://localhost:4000/images/#{resolution.source.id}"
  end

  defp persist_locally(_, %{logo: nil}) do
    {:error, "No logo provided"}
  end

  defp persist_locally(%{thing: %{id: thing_id}}, %{logo: logo}) do
    # This is pretty dumb but it's only for local dev so whatever
    System.cmd("cp", [logo.path, "./priv/static/images/#{thing_id}"])
    {:ok, nil}
  end
end
