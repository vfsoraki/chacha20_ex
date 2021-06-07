defmodule Chacha20.MixProject do
  use Mix.Project

  def project do
    [
      app: :chacha20,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: [
        chacha20_ex: [
          mode: (if Mix.env() == :prod, do: :release, else: :debug)
        ]
      ],
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler, "~> 0.21.1"}
    ]
  end
end
