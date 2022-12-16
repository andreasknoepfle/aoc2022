defmodule Aoc2022.Door03 do
  use Aoc2022.DoorBehaviour

  def run_a(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_charlist/1)
    |> Stream.map(&Enum.chunk_every(&1, round(length(&1) / 2)))
    |> Stream.map(&common_item/1)
    |> Stream.map(&score/1)
    |> Enum.sum()
  end

  def run_b(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_charlist/1)
    |> Stream.chunk_every(3)
    |> Stream.map(&common_item/1)
    |> Stream.map(&score/1)
    |> Enum.sum()
  end

  defp common_item(lists) do
    [item | _] = common_items(lists)
    item
  end

  defp common_items([list, other_list | rest]) when rest != [] do
    common_items([common_items([list, other_list]) | rest])
  end

  defp common_items([list, other_list]) do
    list -- list -- other_list
  end

  defp score(char) when char > 96, do: char - 96
  defp score(char), do: char - 64 + 26
end
