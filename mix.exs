defmodule ExMatch.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_match,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExMatch.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.1"},
      {:ecto, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:bypass, "~> 1.0", only: :test}
    ]
  end
end
