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
