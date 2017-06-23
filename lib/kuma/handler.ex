defmodule Kuma.Handler do
  defmacro __using__(_) do
    do_use()
  end

  @doc false
  def do_use() do
    quote do
      use GenServer

      require Logger

      alias ExIrc.Client
      alias ExIrc.SenderInfo
      alias Kuma.Bot

      @doc false
      def start_link(conn) do
        GenServer.start_link(__MODULE__, [conn])
      end

      @doc false
      def init([conn]) do
        Client.add_handler conn.client, self()
        {:ok, conn}
      end
    end
  end

  # defmacro overhear(pattern, channel, sender_info, do: block) do
  #   quote do
  #     def handle_info({:received, msg, unqoute(sender_info), unquote(channel)}, conn) do
  #       if String.match? msg, unquote(pattern) do
  #         unquote(block)
  #       end
  #       {:noreply, conn}
  #     end
  #   end
  # end
end