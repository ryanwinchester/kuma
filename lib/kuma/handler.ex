defmodule Kuma.Handler do
  use GenServer

  require Logger

  alias ExIrc.Client
  alias ExIrc.SenderInfo
  alias Kuma.Bot

  def start_link(conn) do
    GenServer.start_link(__MODULE__, [conn])
  end

  def init([conn]) do
    Client.add_handler conn.client, self()
    {:ok, conn}
  end

  defmacro overhear(pattern, channel, sender_info, do: block) do
    quote do
      def handle_info({:received, msg, unqoute(sender_info), unquote(channel)}, conn) do
        if String.match? msg, unquote(pattern) do
          unquote(block)
        end
        {:noreply, conn}
      end
    end
  end
end