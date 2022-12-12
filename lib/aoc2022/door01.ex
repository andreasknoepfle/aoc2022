defmodule Aoc2022.Door01 do
  def run_a(stream) do
    {current, max} =
      Enum.reduce(stream, {0, 0}, fn line, {current, max} ->
        result = Enum.max([current, max])

        case line do
          "\n" ->
            {0, result}

          data ->
            {parse(data) + current, max}
        end
      end)

    Enum.max([current, max])
  end

  def run_b(stream) do
    {current, list} =
      Enum.reduce(stream, {0, []}, fn line, {current, list} ->
        case line do
          "\n" ->
            {0, [current | list]}

          data ->
            {parse(data) + current, list}
        end
      end)

    [current | list] |> Enum.sort(:desc) |> Enum.take(3) |> Enum.sum()
  end

  defp parse(data) do
    data |> String.trim() |> String.to_integer()
  end
end
