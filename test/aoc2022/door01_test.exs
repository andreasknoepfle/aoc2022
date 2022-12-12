defmodule Aoc2022.Door01Test do
  use Aoc2022.DoorCase, async: true
  alias Aoc2022.Door01

  @input """
         1000
         2000
         3000

         4000

         5000
         6000

         7000
         8000
         9000

         10000
         """
         |> fake_stream()

  test "run_a/0" do
    assert 24000 == Door01.run_a(@input)
  end

  test "run_b/0" do
    assert 45000 == Door01.run_b(@input)
  end
end
