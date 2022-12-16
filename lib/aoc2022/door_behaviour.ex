defmodule Aoc2022.DoorBehaviour do
  @callback run_a(input :: Enumerable.t()) :: any()
  @callback run_b(input :: Enumerable.t()) :: any()
  @callback stream_mode() :: :line | :all | integer()

  defmacro __using__(_) do
    quote do
      @behaviour Aoc2022.DoorBehaviour

      def stream_mode(), do: :line
      defoverridable stream_mode: 0
    end
  end
end
