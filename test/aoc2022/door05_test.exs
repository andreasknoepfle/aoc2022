defmodule Aoc2022.Door05Test do
  use Aoc2022.DoorCase

  alias Aoc2022.Door05

  @input ("" <>
            "    [D]    \n" <>
            "[N] [C]    \n" <>
            "[Z] [M] [P]\n" <>
            " 1   2   3 \n\n" <>
            """
            move 1 from 2 to 1
            move 3 from 1 to 3
            move 2 from 2 to 1
            move 1 from 1 to 2
            """)
         |> fake_stream()

  test "run_a/0" do
    assert "CMZ" == Door05.run_a(@input)
  end

  test "run_b/0" do
    assert "MCD" == Door05.run_b(@input)
  end
end
