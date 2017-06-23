defmodule Xircex.ExampleHandler do
  use GenServer

  require Logger

  alias ExIrc.Client
  alias ExIrc.SenderInfo

  def start_link(conn) do
    GenServer.start_link(__MODULE__, [conn])
  end

  def init([conn]) do
    Client.add_handler conn.client, self()
    {:ok, conn}
  end

  def handle_info({:names_list, channel, names_list}, conn) do
    names =
      names_list
      |> String.split(" ", trim: true)
      |> Enum.map(fn name -> " #{name}\n" end)
    Logger.info "Users logged in to #{channel}:\n#{names}"
    {:noreply, conn}
  end

  def handle_info({:received, msg, %SenderInfo{nick: nick}, channel}, conn) do
    Logger.info "#{nick} from #{channel}: #{msg}"
    {:noreply, conn}
  end

  def handle_info({:mentioned, msg, %SenderInfo{nick: nick}, channel}, conn) do
    Logger.warn "#{nick} mentioned you in #{channel}"
    case String.contains?(msg, "hi") do
      true ->
        reply = "Hi #{nick}!"
        Client.msg conn.client, :privmsg, conn.channel, reply
        Logger.info "Sent #{reply} to #{conn.channel}"
      false ->
        :ok
    end
    {:noreply, conn}
  end

  def handle_info({:received, msg, %SenderInfo{nick: nick}}, conn) do
    Logger.warn "#{nick}: #{msg}"
    reply = "Hi!"
    Client.msg conn.client, :privmsg, nick, reply
    Logger.info "Sent #{reply} to #{nick}"
    {:noreply, conn}
  end

  # Catch-all for messages you don't care about
  def handle_info(_msg, conn) do
    {:noreply, conn}
  end
end
