defmodule Aoc2022.Door07Test do
  use Aoc2022.DoorCase

  alias Aoc2022.Door07

  @input """
         $ cd /
         $ ls
         dir a
         14848514 b.txt
         8504156 c.dat
         dir d
         $ cd a
         $ ls
         dir e
         29116 f
         2557 g
         62596 h.lst
         $ cd e
         $ ls
         584 i
         $ cd ..
         $ cd ..
         $ cd d
         $ ls
         4060174 j
         8033020 d.log
         5626152 d.ext
         7214296 k
         """
         |> fake_stream()

  test "run_a/1" do
    assert 95437 == Door07.run_a(@input)
  end

  test "run_b/1" do
    assert 24_933_642 == Door07.run_b(@input)
  end
end
