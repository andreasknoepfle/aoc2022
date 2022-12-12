defmodule Aoc2022.Door03Test do
  use Aoc2022.DoorCase, async: true
  alias Aoc2022.Door03

  @input """
         vJrwpWtwJgWrhcsFMMfFFhFp
         jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
         PmmdzqPrVvPwwTWBwg
         wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
         ttgJtRGJQctTZtZT
         CrZsJsPPZsGzwwsLwLmpwMDw
         """
         |> fake_stream()

  test "run_a/0" do
    assert 157 == Door03.run_a(@input)
  end

  test "run_b/0" do
    assert 70 == Door03.run_b(@input)
  end
end
