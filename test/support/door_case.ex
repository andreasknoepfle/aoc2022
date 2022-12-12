defmodule Aoc2022.DoorCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Aoc2022.DoorCase
    end
  end

  def fake_stream(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n", include_captures: true)
    |> Enum.map(&(&1 <> "\n"))
  end
end
