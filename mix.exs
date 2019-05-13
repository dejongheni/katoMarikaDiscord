defmodule Katomarikadiscord.MixProject do
  use Mix.Project

  def project do
    [
      app: :katomarikadiscord,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :dev,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {KatoMarikaDiscord, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nostrum, git: "https://github.com/Kraigie/nostrum.git"},
      {:distillery, "~> 2.0"}
    ]
  end
end
