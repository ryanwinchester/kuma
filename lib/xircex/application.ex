defmodule Xircex.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Xirc.Bot
  alias Xircex.Conn
  alias Xircex.ConnectionHandler
  alias Xircex.LoginHandler

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    {:ok, client} = ExIrc.start_link!

    conn =
      Application.get_env(:xircex, :bot)
      |> Conn.from_params()
      |> Map.put(:client, client)

    bot = worker(Bot, [client])

    handlers =
      [ConnectionHandler, LoginHandler]
      |> add_custom_handlers()
      |> Enum.map(&worker(&1, [conn]))

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Xircex.Supervisor]
    Supervisor.start_link(bot ++ handlers, opts)
  end

  defp add_custom_handlers(defaults) do
    defaults ++ Application.get_env(:xircex, :custom_handlers, [])
  end
end
