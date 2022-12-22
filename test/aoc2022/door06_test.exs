defmodule Aoc2022.Door06Test do
  use Aoc2022.DoorCase

  alias Aoc2022.Door06

  test "run_a/1" do
    assert 7 == Door06.run_a("mjqjpqmgbljsphdztnvjfqwrcgsmlb" |> fake_stream(:codepoints))
    assert 5 == Door06.run_a("bvwbjplbgvbhsrlpgdmjqwftvncz" |> fake_stream(:codepoints))
    assert 6 == Door06.run_a("nppdvjthqldpwncqszvftbrmjlhg" |> fake_stream(:codepoints))
    assert 10 == Door06.run_a("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" |> fake_stream(:codepoints))
    assert 11 == Door06.run_a("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" |> fake_stream(:codepoints))
  end

  test "run_b/1" do
    assert 19 == Door06.run_b("mjqjpqmgbljsphdztnvjfqwrcgsmlb" |> fake_stream(:codepoints))
    assert 23 == Door06.run_b("bvwbjplbgvbhsrlpgdmjqwftvncz" |> fake_stream(:codepoints))
    assert 23 == Door06.run_b("nppdvjthqldpwncqszvftbrmjlhg" |> fake_stream(:codepoints))
    assert 29 == Door06.run_b("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" |> fake_stream(:codepoints))
    assert 26 == Door06.run_b("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" |> fake_stream(:codepoints))
  end
end
