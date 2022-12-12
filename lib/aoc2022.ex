defmodule Aoc2022 do
  def run(mod) do
    IO.stream(:stdio, :line)
    |> mod.()
    |> IO.puts()
  end
end
