# Kuma

IRC bot

## Installation

The package can be installed by adding `kuma` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:kuma, "~> 0.1.0"}]
end
```

## Config

Add config to your `config/config.exs`

```elixir
config :kuma,
  bot: %{
    server: "chat.freenode.net",
    port: 6697,
    nick: "kuma_test",
    user: "kuma_test",
    name: "Kuma Bot",
    pass: "",
    channels: ["#kuma"],
  },
  custom_handlers: [
    Kuma.ExampleHandler
  ]
```

## Custom Handlers

You'll want to add your own custom handlers.

For example say you want to post something funny when you hear certain phrases:

```elixir
defmodule OverhearHandler do
  use Kuma.Handler

  import Regex, only: [match: 2]

  def handle_info({:received, msg, _sender_info, channel}, conn) do
    cond do
      Regex.match? ~r/srsly guise|seriously,? guys/, msg ->
        Bot.send srsly_guise_img(), channel
      Regex.match? ~r/just do it/, msg ->
        Bot.send "https://www.youtube.com/watch?v=hAEQvlaZgKY", channel
      Regex.match? ~r/┻━┻/, msg ->
        Bot.send "┬──┬◡ﾉ(° -°ﾉ)", channel
    end
    {:noreply, conn}
  end

  # Catch-all for messages you don't care about
  def handle_info(_msg, conn), do: {:noreply, conn}

  defp srsly_guise_img() do
    Enum.random([
      "http://i.imgur.com/0lyao5E.gif",
      "http://i.imgur.com/0lyao5E.gif",
      "http://i.imgur.com/0lyao5E.gif",
      "http://i.imgur.com/xU7AhQh.gif",
      "http://i.imgur.com/dpFlIMx.gif",
      "http://i.imgur.com/mE2oDmm.gif",
      "http://i.imgur.com/ersspRE.gif",
    ])
  end
end
```
