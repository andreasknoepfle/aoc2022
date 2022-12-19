defmodule Aoc2022.Door12 do
  use Aoc2022.DoorBehaviour

  def run_a(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_charlist/1)
    |> Stream.with_index()
    |> Enum.reduce({%{}, nil}, fn {row, index}, {heightmap, goal} ->
      row
      |> Enum.with_index()
      |> Enum.reduce({heightmap, goal}, &convert_row(index, &1, &2))
    end)
    |> find_shortest_path()
  end

  @start ?a
  @goal ?z
  defp convert_row(y, {?S, x}, {map, goal}),
    do: {Map.put(map, {x, y}, {@start, 0, nil}), goal}

  defp convert_row(y, {?E, x}, {map, _}),
    do: {Map.put(map, {x, y}, {@goal, :infinity, nil}), {x, y}}

  defp convert_row(y, {height, x}, {map, goal}),
    do: {Map.put(map, {x, y}, {height, :infinity, nil}), goal}

  defp find_shortest_path({heightmap, goal}) do
    find_shortest_path(heightmap, MapSet.new(Map.keys(heightmap)), goal)
  end

  defp find_shortest_path(heightmap, remaining, goal) do
    {{x, y} = min, {level, distance, _}} =
      heightmap
      |> Map.take(remaining |> MapSet.to_list())
      |> Enum.min_by(fn {_, {_, value, _}} -> value end)

    if min == goal do
      heightmap
      |> Map.get(goal)
      |> elem(1)
    else
      remaining = MapSet.delete(remaining, min)

      heightmap
      |> Map.take([{x - 1, y}, {x, y - 1}, {x + 1, y}, {x, y + 1}])
      |> Enum.filter(fn {key, {other, _, _}} ->
        level + 1 >= other and MapSet.member?(remaining, key)
      end)
      |> Enum.reduce(heightmap, fn {key, {height, other_distance, _}}, map ->
        new_distance = distance + 1

        if new_distance < other_distance do
          Map.put(map, key, {height, new_distance, min})
        else
          map
        end
      end)
      |> find_shortest_path(remaining, goal)
    end
  end

  def run_b(_stream) do
  end
end
