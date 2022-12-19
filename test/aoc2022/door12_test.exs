defmodule Aoc2022.Door12Test do
  use Aoc2022.DoorCase

  alias Aoc2022.Door12

  @input """
         Sabqponm
         abcryxxl
         accszExk
         acctuvwj
         abdefghi
         """
         |> fake_stream()

  @input2 """
          aaabcdefghijaa
          bjaSaaaaajjjkk
          clltuaaaajklal
          dkmsvaaaaaamam
          ejmrwtsrqponmm
          finqxuvwxyzEaa
          ghopyzzzzzzzaa
          """
          |> fake_stream()

  @input3 """
          aaaaaaaaaaaaaaaaaaaaaaaaaaaa
          aaaaaaaaaaaaaaaaaaaaaaaaaaaa
          aaaaaaaaaaaaaaaaaaaaaaaaaaaa
          SabcdefghijklmnopqrstuvwxyzE
          aaaaaaaaaaaaaaaaaaaaaaaaaaaa
          aaaaaaaaaaaaaaaaaaaaaaaaaaaa
          aaaaaaaaaaaaaaaaaaaaaaaaaaaa
          """
          |> fake_stream()

  test "run_a/0" do
    assert 31 == Door12.run_a(@input)
  end

  test "run_b/0" do
    assert nil == Door12.run_b(@input)
  end
end
