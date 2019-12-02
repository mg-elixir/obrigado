defmodule Obrigado do
  @moduledoc """
  Star your Elixir deps on GitHub
  """

  @doc ~S"""
  Return a GitHub client
  """
  def client do
    Tentacat.Client.new(%{access_token: System.get_env("GITHUB_TOKEN")})
  end

  @doc ~S"""
  Parse your deps and star on GitHub
  """
  def star do
    deps = Obrigado.MixProject.project()[:deps]
    parse_and_star_packages(deps)
  end

  @doc ~S"""
  Returns a list with url splitted with / symbol
  """
  def parse_url(url) do
    String.split(url, "/", trim: true)
  end

  @doc ~S"""
  Read metadata from config and performs GitHub API call
  """
  def parse_and_star_packages(packages) do
    Application.ensure_all_started(:hackney)
    packages
      |> Enum.each(fn name ->
        #TODO: get deps dir dynamically from configuration
        case :file.consult('./deps/' ++ Atom.to_charlist(name |> elem(0)) ++ '/hex_metadata.config') do
          {:ok, config} ->
            links = Map.new config
            data = links["links"] |> Enum.map(fn {k,v} -> {String.downcase(k),v} end) |> Map.new
            github_url = data["github"] |> parse_url
            username = Enum.at(github_url, 2)
            reponame = Enum.at(github_url, 3)
            Tentacat.Users.Starring.star client(), username, reponame
            IO.puts("#{Exmoji.unified_to_char("1F496")} #{reponame}")
          {:error, _} ->
            [Atom.to_string(name), "Could not read repository metadata"]
        end
      end)
  end
end
