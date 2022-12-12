defmodule Aoc2022.Door02Test do
  use Aoc2022.DoorCase, async: true
  alias Aoc2022.Door02

  @input """
         A Y
         B X
         C Z
         """
         |> fake_stream()

  test "run_a/0" do
    assert 15 == Door02.run_a(@input)
  end

  test "run_b/0" do
    assert 12 == Door02.run_b(@input)
  end
end
