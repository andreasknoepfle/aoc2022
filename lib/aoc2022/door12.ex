defmodule Aoc2022.Door12 do
  use Aoc2022.DoorBehaviour

  def run_a(stream) do
    {heightmap, start, goal} = build_heightmap(stream)
    graph = build_graph(heightmap)

    length(:digraph.get_short_path(graph, start, goal)) - 1
  end

  defp build_heightmap(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_charlist/1)
    |> Stream.with_index()
    |> Enum.reduce({%{}, nil, nil}, fn {row, index}, {heightmap, start, goal} ->
      row
      |> Enum.with_index()
      |> Enum.reduce({heightmap, start, goal}, &convert_row(index, &1, &2))
    end)
  end

  defp convert_row(y, {?S, x}, {map, _, goal}),
    do: {Map.put(map, {y, x}, 0), {y, x}, goal}

  defp convert_row(y, {?E, x}, {map, start, _}),
    do: {Map.put(map, {y, x}, 25), start, {y, x}}

  defp convert_row(y, {height, x}, {map, start, goal}),
    do: {Map.put(map, {y, x}, height - ?a), start, goal}

  defp build_graph(heightmap) do
    graph = :digraph.new()

    Enum.each(heightmap, fn {v, _} ->
      :digraph.add_vertex(graph, v)
    end)

    Enum.each(heightmap, fn {{y, x} = v, level} ->
      heightmap
      |> Map.take([{y + 1, x}, {y - 1, x}, {y, x - 1}, {y, x + 1}])
      |> Enum.filter(fn {_, height} -> level + 1 >= height end)
      |> Enum.each(fn {new, _} ->
        :digraph.add_edge(graph, v, new)
      end)
    end)

    graph
  end

  def run_b(stream) do
    {heightmap, _, goal} = build_heightmap(stream)

    graph = build_graph(heightmap)

    heightmap
    |> Enum.filter(fn {_, level} -> level == 0 end)
    |> Enum.map(fn {v, _} ->
      if path = :digraph.get_short_path(graph, v, goal) do
        length(path)
      end
    end)
    |> Enum.filter(& &1)
    |> Enum.min()
    |> Kernel.-(1)
  end
end
