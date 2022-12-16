defmodule Aoc2022 do
  def run(mod, part) when part in [:run_a, :run_b] do
    data =
      case mod.stream_mode() do
        :all ->
          IO.read(:stdio)

        mode ->
          IO.stream(:stdio, mode)
      end

    apply(mod, part, [data])
    |> IO.puts()
  end
end
