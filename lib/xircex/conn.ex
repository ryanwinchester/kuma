defmodule Xircex.Conn do
    defstruct [
      host: "chat.freenode.net",
      port: 6667,
      pass: nil,
      nick: nil,
      user: nil,
      name: nil,
      client: nil,
      channels: []
    ]

    def from_params(params) when is_map(params) do
      Enum.reduce(params, %__MODULE__{}, fn {k, v}, acc ->
        case Map.has_key?(acc, k) do
          true  -> Map.put(acc, k, v)
          false -> acc
        end
      end)
    end
  end