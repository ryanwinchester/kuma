# Xircex

IRC bot

## Installation

The package can be installed by adding `xircex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:xircex, "~> 0.1.0"}]
end
```

## Config

```elixir
config :xircex,
  bot: %{
    server: "chat.freenode.net",
    port: 6697,
    nick: "xircex_test",
    user: "xircex_test",
    name: "Xircex Bot",
    pass: "",
    channels: ["#xircex"],
  },
  custom_handlers: [
    Xircex.ExampleHandler
  ]
```
