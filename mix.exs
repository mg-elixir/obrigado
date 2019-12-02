defmodule Obrigado.MixProject do
  use Mix.Project

  def project do
    [
      app: :obrigado,
      description: description(),
      package: package(),
      version: "0.2.1",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp description do
    """
    Star your deps repos on GitHub.
    """
  end

  defp package do
    [
      maintainers:  ["Marat Galiev <kazanlug@gmail.com>"],
      licenses:     ["MIT"],
      links:        %{"GitHub" => "https://github.com/maratgaliev/obrigado"}
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
      {:tentacat, "~> 1.0"},
      {:ex_doc, "~> 0.21.2", only: :dev, runtime: false},
    ]
  end
end
