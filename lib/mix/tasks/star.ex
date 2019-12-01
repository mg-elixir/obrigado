defmodule Mix.Tasks.Star do
  use Mix.Task

  @shortdoc "Runs star method."
  def run(_) do
    Obrigado.star()
  end
end