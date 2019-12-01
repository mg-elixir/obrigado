defmodule Obrigado do
  @doc """
  Star your Elixir deps on GitHub.
  """
  def star do
    Application.ensure_all_started(:hackney)
    client = Tentacat.Client.new(%{access_token: System.get_env("GITHUB_TOKEN")})
    Tentacat.Users.Starring.star client, "elixir-lang", "elixir"
    IO.puts(Exmoji.unified_to_char("1F496"))
    #IO.puts(Obrigado.MixProject.project()[:deps])
    #IO.inspect(IEx.Info.info(Obrigado.MixProject.project()[:deps]))
    Enum.each Obrigado.MixProject.project()[:deps], fn project -> 
      item = project |> elem(0)
      path = Mix.Project.deps_paths()[item]
      read_metadata(path)
      IO.puts(path)
    end
  end

  defp read_metadata(package_path) do
    file_name = "hex_metadata.config"
    path = Path.join(package_path, file_name)
    if File.exists?(path) do
    end
  end
end
