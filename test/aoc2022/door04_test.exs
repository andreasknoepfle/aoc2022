defmodule Aoc2022.Door04Test do
  use Aoc2022.DoorCase, async: true
  alias Aoc2022.Door04

  @input """
         2-4,6-8
         2-3,4-5
         5-7,7-9
         2-8,3-7
         6-6,4-6
         2-6,4-8
         """
         |> fake_stream()

  test "run_a/0" do
    assert 2 == Door04.run_a(@input)
  end

  test "run_b/0" do
    assert 4 == Door04.run_b(@input)
  end
end
