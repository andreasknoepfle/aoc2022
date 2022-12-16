defmodule Aoc2022.Door08Test do
  use Aoc2022.DoorCase

  alias Aoc2022.Door08

  @input """
         30373
         25512
         65332
         33549
         35390
         """
         |> fake_stream()

  test "run_a/0" do
    assert 21 == Door08.run_a(@input)
  end

  test "run_b/0" do
    assert 8 == Door08.run_b(@input)
  end
end
