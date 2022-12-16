defmodule Aoc2022.Door06 do
  use Aoc2022.DoorBehaviour

  def run_a(input) do
    run(input, 4)
  end

  def run_b(input) do
    run(input, 14)
  end

  defp run(input, num_scanned) do
    input
    |> Stream.with_index()
    |> Enum.reduce_while([], fn {element, index}, last_elements ->
      current = Enum.take([element | last_elements], num_scanned)

      if current |> Enum.frequencies() |> Map.keys() |> length() == num_scanned do
        {:halt, index + 1}
      else
        {:cont, current}
      end
    end)
  end

  def stream_mode, do: 1
end
