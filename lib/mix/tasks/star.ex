defmodule Mix.Tasks.Star do
  @moduledoc """
  Custom mix task
  """
  
  use Mix.Task

  @doc ~S"""
  Run main code for task
  """
  def run(_) do
    Obrigado.star()
  end
end