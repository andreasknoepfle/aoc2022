defmodule Aoc2022.Door08 do
  use Aoc2022.DoorBehaviour

  def run_a(stream) do
    {trees, forest_width, forest_height} = to_forest(stream)

    for row <- 1..forest_height, col <- 1..forest_width do
      tree = {row, col}

      if shorter?(trees, tree, {(row - 1)..0, col}) &&
           shorter?(trees, tree, {row, (col - 1)..0}) &&
           shorter?(trees, tree, {(row + 1)..(forest_height + 1), col}) &&
           shorter?(trees, tree, {row, (col + 1)..(forest_width + 1)}) do
        0
      else
        1
      end
    end
    |> Enum.sum()
  end

  def shorter?(trees, tree, {%Range{} = range, y}) do
    Enum.any?(range, fn x -> shorter?(trees, tree, {x, y}) end)
  end

  def shorter?(trees, tree, {x, %Range{} = range}) do
    Enum.any?(range, fn y -> shorter?(trees, tree, {x, y}) end)
  end

  def shorter?(trees, tree, other_tree) do
    Map.get(trees, other_tree, -1) >= Map.get(trees, tree)
  end

  def run_b(stream) do
    {trees, forest_width, forest_height} = to_forest(stream)

    for row <- 1..forest_height, col <- 1..forest_width do
      tree = {row, col}

      score(trees, tree, {row..1, col}) *
        score(trees, tree, {row, col..1}) *
        score(trees, tree, {row..forest_height, col}) *
        score(trees, tree, {row, col..forest_width})
    end
    |> Enum.max()
  end

  defp score(trees, tree, {%Range{} = range, y}) do
    Enum.reduce_while(range, 0, fn x, acc ->
      count_tree(trees, tree, {x, y}, acc)
    end)
  end

  defp score(trees, tree, {x, %Range{} = range}) do
    Enum.reduce_while(range, 0, fn y, acc ->
      count_tree(trees, tree, {x, y}, acc)
    end)
  end

  defp count_tree(trees, tree, other, acc) do
    cond do
      other == tree ->
        {:cont, acc}

      is_nil(Map.get(trees, other)) ->
        {:halt, acc}

      shorter?(trees, tree, other) ->
        {:halt, acc + 1}

      true ->
        {:cont, acc + 1}
    end
  end

  defp to_forest(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.codepoints/1)
    |> Stream.map(&to_tree_row/1)
    |> Stream.map(&Enum.with_index/1)
    |> Stream.with_index()
    |> Enum.reduce({%{}, 0, 0}, fn {row, row_index}, {acc, _, _} ->
      {
        Map.merge(
          acc,
          row |> Map.new(fn {tree, col_index} -> {{row_index + 1, col_index + 1}, tree} end)
        ),
        length(row),
        row_index + 1
      }
    end)
  end

  defp to_tree_row(row), do: Enum.map(row, &to_tree/1)

  defp to_tree(height), do: String.to_integer(height)
end
