defmodule Aoc2022.Door13 do
  use Aoc2022.DoorBehaviour

  def run_a(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&Code.eval_string/1)
    |> Stream.map(&elem(&1, 0))
    |> Stream.chunk_every(3)
    |> Stream.map(&List.delete_at(&1, 2))
    |> Stream.map(&compare/1)
    |> Stream.with_index()
    |> Stream.filter(&elem(&1, 0))
    |> Stream.map(&(elem(&1, 1) + 1))
    |> Enum.sum()
  end

  def compare([a, b]) do
    compare(a, b)
  end

  def compare(a, a), do: nil
  def compare(a, b) when is_number(a) and is_number(b), do: a < b
  def compare(a, b) when is_number(a) and is_list(b), do: compare([a], b)
  def compare(a, b) when is_list(a) and is_number(b), do: compare(a, [b])
  def compare([], [_ | _]), do: true
  def compare([_ | _], []), do: false

  def compare([a | a_rest], [b | b_rest]) do
    if is_nil(result = compare(a, b)) do
      compare(a_rest, b_rest)
    else
      result
    end
  end

  @divider1 [[2]]
  @divider2 [[6]]
  @dividers [@divider1, @divider2]
  def run_b(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&Code.eval_string/1)
    |> Stream.map(&elem(&1, 0))
    |> Stream.filter(& &1)
    |> Stream.concat(@dividers)
    |> Enum.sort(&compare/2)
    |> Enum.with_index()
    |> Enum.filter(fn {packet, _} -> packet in @dividers end)
    |> Enum.map(&(elem(&1, 1) + 1))
    |> Enum.reduce(&Kernel.*/2)
  end
end
