defmodule Aoc2022.Door16Test do
  use Aoc2022.DoorCase, async: true
  alias Aoc2022.Door16

  @input """
         Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
         Valve BB has flow rate=13; tunnels lead to valves CC, AA
         Valve CC has flow rate=2; tunnels lead to valves DD, BB
         Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
         Valve EE has flow rate=3; tunnels lead to valves FF, DD
         Valve FF has flow rate=0; tunnels lead to valves EE, GG
         Valve GG has flow rate=0; tunnels lead to valves FF, HH
         Valve HH has flow rate=22; tunnel leads to valve GG
         Valve II has flow rate=0; tunnels lead to valves AA, JJ
         Valve JJ has flow rate=21; tunnel leads to valve II
         """
         |> fake_stream()

  test "run_a/1" do
    assert 1651 == Door16.run_a(@input)
  end

  test "run_b/1" do
    assert 1707 == Door16.run_b(@input)
  end
end
