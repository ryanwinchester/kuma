defmodule Xircex.ConnectionHandler do
  use GenServer

  require Logger

  alias ExIrc.Client

  def start_link(%{nick: nick} = conn) do
    GenServer.start_link(__MODULE__, [conn], name: String.to_atom(nick))
  end

  def init([conn]) do
    Client.add_handler conn.client, self()

    Logger.debug "Connecting to #{conn.host}:#{conn.port}"
    Client.connect_ssl! conn.client, conn.host, conn.port

    {:ok, conn}
  end

  def handle_info({:connected, host, port}, conn) do
    Logger.debug "Connected to #{host}:#{port}"
    Logger.debug "Logging to #{host}:#{port} as #{conn.nick}.."
    Client.logon conn.client, conn.pass, conn.nick, conn.user, conn.name
    {:noreply, conn}
  end

  def handle_info(:disconnected, conn) do
    Logger.debug "Disconnected from #{conn.host}:#{conn.port}"
    {:stop, :normal, conn}
  end

  # Catch-all for messages you don't care about
  def handle_info(_msg, conn) do
    {:noreply, conn}
  end

  def terminate(_, conn) do
    # Quit the channels and close the underlying client connection when the process is terminating
    Logger.warn "Terminating..."
    Client.quit conn.client, "Goodbye, cruel world."
    Client.stop! conn.client
    :ok
  end
end
