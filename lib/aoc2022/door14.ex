defmodule Aoc2022.Door14 do
  use Aoc2022.DoorBehaviour

  def run_a(stream) do
    rocks = parse_rocks(stream)

    source()
    |> Enum.reduce_while(rocks, &sand_falling(&1, &2, {:abyss, last_rock(rocks)}))
  end

  @source {500, 0}

  def source do
    [@source]
    |> Stream.cycle()
    |> Stream.with_index()
  end

  defp parse_rocks(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, " -> "))
    |> Stream.flat_map(&to_rock/1)
    |> Enum.into(MapSet.new())
  end

  defp to_rock(path) do
    path
    |> Enum.map(fn coordinate ->
      coordinate
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce([], fn [{a, b}, {c, d}], acc ->
      acc ++
        for i <- a..c, j <- b..d do
          {i, j}
        end
    end)
    |> Enum.uniq()
  end

  defp last_rock(rocks) do
    Enum.map(rocks, &elem(&1, 1)) |> Enum.max()
  end

  defp sand_falling({new_sand, index}, sand_and_rocks, until) do
    case fall(new_sand, sand_and_rocks, until) do
      :halt -> {:halt, index}
      acc -> {:cont, acc}
    end
  end

  def fall({_, abyss}, _sand_and_rocks, {:abyss, abyss}), do: :halt

  def fall({x, y} = sand, sand_and_rocks, until) do
    [{x, y + 1}, {x - 1, y + 1}, {x + 1, y + 1}]
    |> Enum.find(&free?(&1, sand_and_rocks, until))
    |> case do
      nil -> if sand == @source, do: :halt, else: MapSet.put(sand_and_rocks, sand)
      value -> fall(value, sand_and_rocks, until)
    end
  end

  def free?({_, y}, _sand_and_rocks, {:floor, y}), do: false

  def free?(sand, sand_and_rocks, _) do
    !MapSet.member?(sand_and_rocks, sand)
  end

  def run_b(stream) do
    rocks = parse_rocks(stream)

    source()
    |> Enum.reduce_while(rocks, &sand_falling(&1, &2, {:floor, last_rock(rocks) + 2}))
    |> Kernel.+(1)
  end
end
