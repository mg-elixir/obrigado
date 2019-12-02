defmodule Obrigado do
  @doc """
  Star your Elixir deps on GitHub.
  """
  def client do
    Tentacat.Client.new(%{access_token: System.get_env("GITHUB_TOKEN")})
  end

  def star do
    deps = Obrigado.MixProject.project()[:deps]
    parse_and_star_packages(deps)
  end

  def parse_url(url) do
    String.split(url, "/", trim: true)
  end

  #TODO: get deps dir dynamically from configuration
  def parse_and_star_packages(packages) do
    Application.ensure_all_started(:hackney)
    packages
      |> Enum.each(fn name ->
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
