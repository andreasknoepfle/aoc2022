defmodule Aoc2022.Door05 do
  def run_a(stream) do
    stream
    |> build_instructions()
    |> Enum.reduce(build_stacks(stream), &move(&1, &2))
    |> result()
  end

  def run_b(stream) do
    stream
    |> build_instructions()
    |> Enum.reduce(build_stacks(stream), &move(&1, &2, false))
    |> result()
  end

  defp build_stacks(stream) do
    stream
    |> Stream.take_while(&stack?/1)
    |> Stream.map(&String.codepoints/1)
    |> Stream.map(&Enum.chunk_every(&1, 4))
    |> Stream.map(fn chunks ->
      Enum.map(chunks, &(&1 |> Enum.join() |> id()))
    end)
    |> Stream.zip_with(& &1)
    |> Stream.map(fn stacks -> Enum.filter(stacks, & &1) end)
    |> Enum.into([])
  end

  defp build_instructions(stream) do
    stream
    |> Stream.drop_while(&(!instructions?(&1)))
    |> Stream.map(&parse/1)
  end

  defp result(stacks) do
    stacks
    |> Enum.map(&List.first/1)
    |> Enum.join()
  end

  defp parse(instruction) do
    Regex.named_captures(~r/move (?<move>\w*) from (?<from>\w*) to (?<to>\w*)/, instruction)
  end

  defp move(%{"move" => move, "from" => from, "to" => to}, stacks, reverse \\ true) do
    from_index = String.to_integer(from) - 1
    to_index = String.to_integer(to) - 1
    {moved, rest} = stacks |> Enum.at(from_index) |> Enum.split(String.to_integer(move))

    put_fun = if reverse, do: &Enum.reverse/1, else: & &1

    stacks
    |> List.update_at(from_index, fn _ -> rest end)
    |> List.update_at(to_index, &(put_fun.(moved) ++ &1))
  end

  defp stack?(line) do
    !String.starts_with?(line, " 1")
  end

  defp instructions?(line) do
    String.starts_with?(line, "move")
  end

  defp id(string) do
    string |> String.trim() |> String.codepoints() |> Enum.at(1)
  end
end
