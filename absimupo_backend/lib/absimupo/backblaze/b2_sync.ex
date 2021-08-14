defmodule Absimupo.Backblaze.B2Sync do
  @moduledoc """
  A simple GenServer that refreshes the B2 config on a fixed frequency.
  """
  use GenServer
  require Logger

  @skip_envs [:test]
  @hours_between_syncs 12

  @doc """
  Starts the GenServer
  """
  @spec start_link(term()) :: GenServer.on_start()
  def start_link(initial_val) do
    GenServer.start_link(__MODULE__, initial_val)
  end

  @doc """
  Starts the sync cycle, provide we are not in any of the @skip_envs
  """
  @spec init(term()) :: {:ok, []}
  def init(_val) do
    unless Mix.env() in @skip_envs do
      Process.send(self(), :sync, [])
    end

    {:ok, []}
  end

  @doc """
  Authorizes with B2 and gets the upload URL
  """
  @spec handle_info(:sync, term()) :: {:noreply, []}
  def handle_info(:sync, _val) do
    Logger.info("Refreshing B2 config...")

    Absimupo.Backblaze.authorize_account()
    Absimupo.Backblaze.get_upload_url()
    Application.put_env(:absimupo, :backblaze_configured, true)

    Logger.info("Refreshed B2 config.")
    Process.send_after(self(), :sync, 1000 * 60 * 60 * @hours_between_syncs)
    {:noreply, []}
  end
end
