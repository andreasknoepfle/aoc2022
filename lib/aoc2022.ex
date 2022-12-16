defmodule Aoc2022 do
  def run(mod, part) when part in [:run_a, :run_b] do
    stream = IO.stream(:stdio, mod.stream_mode())

    apply(mod, part, [stream])
    |> IO.puts()
  end
end
