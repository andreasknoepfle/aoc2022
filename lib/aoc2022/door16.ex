defmodule Aoc2022.Door16 do
  use Aoc2022.DoorBehaviour

  defmodule Cache do
    def setup() do
      :ets.new(:routing, [
        # gives us key=>value semantics
        :set,

        # allows any process to read/write to our table
        :public,

        # allow the ETS table to access by it's name, `:myapp_users`
        :named_table,

        # favor read-locks over write-locks
        read_concurrency: true,

        # internally split the ETS table into buckets to reduce
        # write-lock contention
        write_concurrency: true
      ])
    end

    def get(key, build_fn) do
      case :ets.lookup(:routing, key) do
        [{_key, value}] ->
          value

        _ ->
          value = build_fn.()
          put(key, value)
          value
      end
    end

    defp put(key, value) do
      :ets.insert(:routing, {key, value})
    end
  end

  def run_a(stream) do
    Cache.setup()

    {graph, valves} = parse_valves_and_build_graph(stream)
    max_flow(graph, valves, :AA, 30)
  end

  def run_b(stream) do
    Cache.setup()

    {graph, valves} = parse_valves_and_build_graph(stream)

    valves
    |> possible_subsets()
    |> Enum.map(fn me ->
      elefant = valves -- me

      max_flow(graph, me, :AA, 26) +
        max_flow(graph, elefant, :AA, 26)
    end)
    |> Enum.max()
  end

  defp possible_subsets([valve]), do: [[], [valve]]

  defp possible_subsets([valve | others]) do
    subsets = possible_subsets(others)
    subsets ++ Enum.map(subsets, &[valve | &1])
  end

  defp parse_valves_and_build_graph(stream) do
    graph = :digraph.new()

    valves =
      stream
      |> Stream.map(&parse_valve_and_build_graph(&1, graph))
      |> Enum.filter(&(elem(&1, 1) != 0))

    {graph, valves}
  end

  defp parse_valve_and_build_graph(data, graph) do
    [_, valve, flow, others] =
      Regex.run(
        ~r/Valve (\w*) has flow rate=(\d*); tunnels? leads? to valves? (.*)/,
        data
      )

    valve = valve |> String.to_atom()
    :digraph.add_vertex(graph, valve)
    others = String.split(others, ",") |> Enum.map(&String.trim/1) |> Enum.map(&String.to_atom/1)
    flow = String.to_integer(flow)

    Enum.each(others, fn other ->
      :digraph.add_vertex(graph, other)
      :digraph.add_edge(graph, valve, other)
    end)

    {valve, flow}
  end

  def max_flow(_, [], _, _), do: 0
  def max_flow(_, _, _, time) when time <= 1, do: 0

  def max_flow(graph, list, current, time) do
    for {next, flow} = valve <- list do
      remaining =
        time -
          Cache.get({current, next}, fn ->
            graph
            |> :digraph.get_short_path(current, next)
            |> length()
          end)

      Enum.max([
        0,
        remaining * flow +
          max_flow(graph, list -- [valve], next, remaining)
      ])
    end
    |> Enum.max()
  end
end
