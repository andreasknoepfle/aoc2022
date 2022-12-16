defmodule Aoc2022.Door04 do
  use Aoc2022.DoorBehaviour

  def run_a(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, ","))
    |> Stream.map(&to_ranges/1)
    |> Enum.filter(&pair_some_contain?/1)
    |> length()
  end

  def run_b(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, ","))
    |> Stream.map(&to_ranges/1)
    |> Enum.filter(&overlap/1)
    |> length()
  end

  defp to_ranges(ranges), do: Enum.map(ranges, &to_range/1)

  defp to_range(range) do
    [first, last] =
      range
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)

    Range.new(first, last)
  end

  defp pair_some_contain?([range, other_range]) do
    contained_in?(range, other_range) or contained_in?(other_range, range)
  end

  defp contained_in?(range, other_range) do
    other_range.first <= range.first && other_range.last >= range.last
  end

  def overlap([range, other_range]) do
    !Range.disjoint?(range, other_range)
  end
end
