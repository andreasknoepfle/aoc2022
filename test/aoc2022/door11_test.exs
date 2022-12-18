defmodule Aoc2022.Door11Test do
  use Aoc2022.DoorCase

  alias Aoc2022.Door11

  @input """
         Monkey 0:
         Starting items: 79, 98
         Operation: new = old * 19
         Test: divisible by 23
           If true: throw to monkey 2
           If false: throw to monkey 3

         Monkey 1:
         Starting items: 54, 65, 75, 74
         Operation: new = old + 6
         Test: divisible by 19
           If true: throw to monkey 2
           If false: throw to monkey 0

         Monkey 2:
         Starting items: 79, 60, 97
         Operation: new = old * old
         Test: divisible by 13
           If true: throw to monkey 1
           If false: throw to monkey 3

         Monkey 3:
         Starting items: 74
         Operation: new = old + 3
         Test: divisible by 17
           If true: throw to monkey 0
           If false: throw to monkey 1
         """
         |> fake_stream()

  test "run_a/0" do
    assert 10605 == Door11.run_a(@input)
  end

  test "run_b/0" do
    assert 2_713_310_158 == Door11.run_b(@input)
  end
end
