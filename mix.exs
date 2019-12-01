defmodule Obrigado.MixProject do
  use Mix.Project

  def project do
    [
      app: :obrigado,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      applications: [:tentacat],
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:exmoji, "~> 0.2.2"},
      {:tentacat, "~> 1.0"}
    ]
  end
end
