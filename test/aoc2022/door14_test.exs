defmodule Aoc2022.Door14Test do
  use Aoc2022.DoorCase, async: true
  alias Aoc2022.Door14

  @input """
         498,4 -> 498,6 -> 496,6
         503,4 -> 502,4 -> 502,9 -> 494,9
         """
         |> fake_stream()

  test "run_a/1" do
    assert 24 == Door14.run_a(@input)
  end

  test "run_b/1" do
    assert 93 == Door14.run_b(@input)
  end
end
