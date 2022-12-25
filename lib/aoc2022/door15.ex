defmodule Aoc2022.Door15 do
  use Aoc2022.DoorBehaviour

  def run_a(stream, row \\ 2_000_000) do
    stream
    |> Stream.map(&parse_sensor/1)
    |> ranges(row)
    |> Enum.reduce(0, &(&2 + Range.size(&1) - 1))
  end

  defp parse_sensor(sensor) do
    [_ | values] =
      Regex.run(
        ~r/Sensor at x=(-?\d*), y=(-?\d*): closest beacon is at x=(-?\d*), y=(-?\d*)/,
        sensor
      )

    [x1, y1, x2, y2] = values |> Enum.map(&String.to_integer/1)
    {x1, y1, abs(x2 - x1) + abs(y2 - y1)}
  end

  defp ranges(sensors, row) do
    sensors
    |> Stream.map(&intersections(&1, row))
    |> Stream.filter(& &1)
    |> compact_ranges()
  end

  defp intersections({x, y, distance}, row) do
    max_x = distance - abs(row - y)

    if max_x > 0 do
      (x - max_x)..(x + max_x)
    else
      nil
    end
  end

  defp compact_ranges(ranges) do
    ranges
    |> Enum.sort_by(& &1.first)
    |> Enum.reduce(fn current_range, acc ->
      [last_range | rest] = ranges = List.wrap(acc)

      if Range.disjoint?(last_range, current_range) do
        [current_range | ranges]
      else
        [%{last_range | last: Enum.max([current_range.last, last_range.last])} | rest]
      end
    end)
  end

  def run_b(stream, max_range \\ 4_000_000) do
    sensors = stream |> Enum.map(&parse_sensor/1)

    {[%Range{first: x} | _], y} =
      0..max_range
      |> Stream.map(&{ranges(sensors, &1), &1})
      |> Enum.find(&(length(elem(&1, 0)) > 1))

    (x - 1) * 4_000_000 + y
  end
end
