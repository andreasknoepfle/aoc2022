defmodule Aoc2022.Door07 do
  use Aoc2022.DoorBehaviour

  defmodule Node do
    defstruct [:type, size: 0, children: MapSet.new()]
  end

  def run_a(stream) do
    stream
    |> parse()
    |> Map.delete("/")
    |> total_dir_sizes()
    |> Stream.filter(&(&1 <= 100_000))
    |> Enum.sum()
  end

  def run_b(stream) do
    nodes = parse(stream)
    remaining = 70_000_000 - total_size(nodes, "/")
    free_up_min = 30_000_000 - remaining

    nodes
    |> total_dir_sizes()
    |> Stream.filter(&(&1 >= free_up_min))
    |> Enum.min()
  end

  defp parse(stream) do
    {nodes, _} =
      stream
      |> Stream.map(&String.trim/1)
      |> Enum.reduce({%{}, ""}, fn input, {nodes, current_path} ->
        case input do
          "$ cd " <> dir ->
            new_path = Path.join(current_path, dir) |> Path.expand("/")
            {folder(nodes, new_path), new_path}

          "$ ls" ->
            {nodes, current_path}

          "dir " <> name ->
            path = Path.join(current_path, name)
            nodes = nodes |> folder(path) |> child(current_path, name)
            {nodes, current_path}

          file ->
            [size, name] = String.split(file, " ")
            path = Path.join(current_path, name)
            nodes = nodes |> file(path, size) |> child(current_path, name)
            {nodes, current_path}
        end
      end)

    nodes
  end

  defp total_dir_sizes(nodes) do
    nodes
    |> Stream.filter(fn {_, %{type: type}} -> type == :dir end)
    |> Stream.map(fn {path, _} -> total_size(nodes, path) end)
  end

  defp folder(nodes, path) do
    Map.put_new(nodes, path, %Node{type: :dir})
  end

  defp file(nodes, path, size) do
    Map.put_new(nodes, path, %Node{type: :file, size: String.to_integer(size)})
  end

  defp child(nodes, path, child) do
    Map.update!(nodes, path, fn node -> Map.update!(node, :children, &MapSet.put(&1, child)) end)
  end

  defp total_size(nodes, path) do
    node = Map.get(nodes, path)
    node.size + (Enum.map(node.children, &total_size(nodes, Path.join(path, &1))) |> Enum.sum())
  end
end
