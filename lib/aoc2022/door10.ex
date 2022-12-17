defmodule Aoc2022.Door10 do
  use Aoc2022.DoorBehaviour

  def run_a(stream) do
    stream
    |> cpu()
    |> Stream.transform(1, fn value, cycle ->
      if rem(cycle, 40) == 19 do
        {[value * (cycle + 1)], cycle + 1}
      else
        {[], cycle + 1}
      end
    end)
    |> Enum.sum()
  end

  def run_b(stream) do
    stream
    |> cpu()
    |> Stream.transform({1, 0}, fn value, {acc, cycle} ->
      pixel =
        if cycle in [acc - 1, acc, acc + 1] do
          "#"
        else
          "."
        end

      {[pixel], {value, rem(cycle + 1, 40)}}
    end)
    |> Stream.chunk_every(40)
    |> Enum.join("\n")
  end

  defp cpu(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.transform(1, fn instruction, acc ->
      case instruction do
        "addx " <> value ->
          number = String.to_integer(value)
          {[acc, acc + number], acc + number}

        _ ->
          {[acc], acc}
      end
    end)
  end
end
