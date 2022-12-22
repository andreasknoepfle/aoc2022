defmodule Aoc2022.Door13Test do
  use Aoc2022.DoorCase, async: true
  alias Aoc2022.Door13

  @input """
         [1,1,3,1,1]
         [1,1,5,1,1]

         [[1],[2,3,4]]
         [[1],4]

         [9]
         [[8,7,6]]

         [[4,4],4,4]
         [[4,4],4,4,4]

         [7,7,7,7]
         [7,7,7]

         []
         [3]

         [[[]]]
         [[]]

         [1,[2,[3,[4,[5,6,7]]]],8,9]
         [1,[2,[3,[4,[5,6,0]]]],8,9]

         """
         |> fake_stream()

  test "run_a/0" do
    assert 13 == Door13.run_a(@input)
  end

  test "run_b/0" do
    assert 140 == Door13.run_b(@input)
  end
end
