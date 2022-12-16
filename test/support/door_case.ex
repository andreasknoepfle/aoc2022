defmodule Aoc2022.DoorCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Aoc2022.DoorCase
    end
  end

  def fake_stream(input, mode \\ :line)

  def fake_stream(input, :line) do
    input
    |> String.trim_trailing()
    |> String.split("\n", include_captures: true)
    |> Enum.map(&(&1 <> "\n"))
  end

  def fake_stream(input, :codepoints) do
    input
    |> String.trim_trailing()
    |> String.codepoints()
  end
end
