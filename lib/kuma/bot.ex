defmodule Kuma.Bot do
  @moduledoc """
  IRC Bot
  """

  use GenServer

  alias ExIrc.Client

  ### Client API

  def start_link(client) do
    GenServer.start_link(__MODULE__, client, name: __MODULE__)
  end

  @doc """
  Send a message to a channel.
  """
  def send(message, channel), do: GenServer.cast(__MODULE__, {:msg, message, channel})

  @doc """
  Send a message to a channel as a reply to a user.
  """
  def reply(message, channel, nick), do: GenServer.cast(__MODULE__, {:msg, message, channel, nick})

  @doc """
  Send a private message to a user.
  """
  def message(message, nick), do: GenServer.cast(__MODULE__, {:msg, message, nick})

  ### GenServer API

  @doc """
  GenServer.init/1 callback
  """
  def init(client), do: {:ok, client}

  @doc """
  GenServer.handle_cast/2 callback
  """
  def handle_cast({:msg, message, recipient}, client) do
    Client.msg client, :privmsg, recipient, message
    {:noreply, client}
  end

  def handle_cast({:msg, message, channel, nick}, client) do
    Client.msg client, :privmsg, channel, "#{nick}: #{message}"
    {:noreply, client}
  end
end
