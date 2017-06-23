defmodule Kuma.LoginHandler do
  use GenServer

  require Logger

  alias ExIrc.Client

  @doc false
  def start_link(conn) do
    GenServer.start_link(__MODULE__, [conn])
  end

  @doc false
  def init([conn]) do
    Client.add_handler conn.client, self()
    {:ok, conn}
  end

  def handle_info(:logged_in, conn = %{client: client, channels: channels}) do
    Logger.debug "Logged in to #{conn.host}:#{conn.port}"
    Logger.debug "Joining channels..."
    Enum.map(channels, &Client.join(client, &1))
    {:noreply, conn}
  end

  def handle_info({:joined, channel}, conn) do
    Logger.debug "Joined #{channel}"
    {:noreply, conn}
  end

  # Catch-all for messages you don't care about
  def handle_info(_msg, conn) do
    {:noreply, conn}
  end
end
