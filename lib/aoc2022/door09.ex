defmodule Aoc2022.Door09 do
  use Aoc2022.DoorBehaviour

  def run_a(stream) do
    {_, positions} =
      stream
      |> Stream.map(&parse_direction/1)
      |> Enum.reduce({[{0, 0}, {0, 0}], MapSet.new()}, fn input, acc ->
        move(acc, input)
      end)

    MapSet.size(positions)
  end

  defp parse_direction(direction) do
    [direction, steps] = direction |> String.trim() |> String.split(" ")
    steps = String.to_integer(steps)

    direction =
      case direction do
        "R" -> {1, 0}
        "L" -> {-1, 0}
        "U" -> {0, -1}
        "D" -> {0, 1}
      end

    {direction, steps}
  end

  defp move(acc, {_, 0}), do: acc

  defp move({[head | knots], positions}, {dir, steps}) do
    head = move_head(head, dir)
    knots = Enum.scan(knots, head, &move_knot/2)
    move({[head | knots], MapSet.put(positions, List.last(knots))}, {dir, steps - 1})
  end

  defp move_head({x, y}, {dir_x, dir_y}) do
    {x + dir_x, y + dir_y}
  end

  defp move_knot({follow_x, follow_y} = follow, {lead_x, lead_y} = lead) do
    touch = touch(lead, follow)
    {move_axis(lead_x, follow_x, touch), move_axis(lead_y, follow_y, touch)}
  end

  defp touch({lead_x, lead_y}, {follow_x, follow_y})
       when abs(lead_x - follow_x) < 2 and abs(lead_y - follow_y) < 2,
       do: true

  defp touch(_, _), do: false

  defp move_axis(lead, follow, false) when lead == follow, do: follow
  defp move_axis(lead, follow, true) when abs(lead - follow) < 2, do: follow
  defp move_axis(lead, follow, _), do: follow + round((lead - follow) / abs(lead - follow))

  def run_b(stream) do
    {_, positions} =
      stream
      |> Stream.map(&parse_direction/1)
      |> Enum.reduce({List.duplicate({0, 0}, 10), MapSet.new()}, fn input, acc ->
        move(acc, input)
      end)

    MapSet.size(positions)
  end
end
