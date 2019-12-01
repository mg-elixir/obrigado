defmodule ObrigadoTest do
  use ExUnit.Case
  doctest Obrigado

  test "greets the world" do
    assert Obrigado.hello() == :world
  end
end
