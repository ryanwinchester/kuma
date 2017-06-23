defmodule Kuma.Mixfile do
  use Mix.Project

  def project do
    [
      app: :kuma,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/ryanwinchester/kuma",
      name: "Kuma",
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [
      extra_applications: [:logger],
      mod: {Kuma.Application, []}
    ]
  end

  defp description do
    """
    An Elixir IRC Bot
    """
  end

  defp package do
    [
      name: :kuma,
      maintainers: ["Ryan Winchester"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/ryanwinchester/kuma"},
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:exirc, "~> 1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end
end
