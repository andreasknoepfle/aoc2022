defmodule Aoc2022.Door02 do
  use Aoc2022.DoorBehaviour

  @picks [:rock, :paper, :scissors]

  def run_a(stream) do
    Enum.reduce(stream, 0, fn line, acc ->
      [opponent, player] =
        line
        |> String.trim()
        |> String.split(" ")
        |> Enum.map(&translate/1)

      score(player) + score(opponent, player) + acc
    end)
  end

  defp translate("A"), do: :rock
  defp translate("B"), do: :paper
  defp translate("C"), do: :scissors
  defp translate("X"), do: :rock
  defp translate("Y"), do: :paper
  defp translate("Z"), do: :scissors

  defp score(:rock), do: 1
  defp score(:paper), do: 2
  defp score(:scissors), do: 3
  defp score(a, a), do: 3
  defp score(:rock, :scissors), do: 0
  defp score(:paper, :rock), do: 0
  defp score(:scissors, :paper), do: 0
  defp score(a, b), do: 6 - score(b, a)

  def run_b(stream) do
    Enum.reduce(stream, 0, fn line, acc ->
      [opponent, player] =
        line
        |> String.trim()
        |> String.split(" ")

      needs = needs(player)
      opponent = opponent |> translate()
      pick = Enum.find(@picks, fn p -> score(opponent, p) == needs end)

      score(pick) + needs + acc
    end)
  end

  defp needs("X"), do: 0
  defp needs("Y"), do: 3
  defp needs("Z"), do: 6
end
