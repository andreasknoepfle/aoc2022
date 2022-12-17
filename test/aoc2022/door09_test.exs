defmodule Aoc2022.Door09Test do
  use Aoc2022.DoorCase

  alias Aoc2022.Door09

  @input """
         R 4
         U 4
         L 3
         D 1
         R 4
         D 1
         L 5
         R 2
         """
         |> fake_stream()

  @input_b """
           R 5
           U 8
           L 8
           D 3
           R 17
           D 10
           L 25
           U 20
           """
           |> fake_stream()

  test "run_a/0" do
    assert 13 == Door09.run_a(@input)
  end

  test "run_b/0" do
    assert 1 == Door09.run_b(@input)
    assert 36 == Door09.run_b(@input_b)
  end
end
