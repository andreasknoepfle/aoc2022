defmodule Aoc2022.Door11 do
  use Aoc2022.DoorBehaviour

  defmodule Monkey do
    use GenServer

    defstruct [:operation, :test, :divisor, items: [], inspect: 0]

    def init(monkey) do
      {:ok, monkey}
    end

    def start_link({monkey, index}) do
      GenServer.start_link(__MODULE__, monkey, name: name(index))
    end

    def turn(pid, reduce \\ nil) do
      GenServer.call(pid, {:turn, reduce})
    end

    def inspect(pid) do
      GenServer.call(pid, :inspect)
    end

    def throw_to(index, worry) do
      GenServer.cast(name(index), {:throw, worry})
    end

    def handle_call({:turn, reduce}, _, monkey) do
      monkey.items
      |> Enum.each(fn item ->
        worry = monkey.operation.(item)

        if(reduce, do: Integer.mod(worry, reduce), else: div(worry, 3))
        |> monkey.test.()
      end)

      inspect = monkey.inspect + length(monkey.items)
      {:reply, inspect, %{monkey | items: [], inspect: inspect}}
    end

    def handle_call(:inspect, _, monkey) do
      {:reply, monkey.inspect, monkey}
    end

    def handle_cast({:throw, worry}, monkey) do
      {:noreply, %{monkey | items: monkey.items ++ [worry]}}
    end

    defp name(index) do
      {:global, {__MODULE__, index}}
    end
  end

  def run_a(stream) do
    monkey_pids = stream |> build_monkeys() |> start_monkeys()
    for _ <- 1..20, do: Enum.map(monkey_pids, &Monkey.turn/1)
    monkey_business(monkey_pids)
  end

  def run_b(stream) do
    monkeys = build_monkeys(stream)
    monkey_pids = start_monkeys(monkeys)
    reduce = monkeys |> Enum.map(& &1.divisor) |> Enum.reduce(&Kernel.*/2)
    for _ <- 1..10_000, do: Enum.map(monkey_pids, &Monkey.turn(&1, reduce))
    monkey_business(monkey_pids)
  end

  defp build_monkeys(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.chunk_every(7)
    |> Stream.map(&to_monkey/1)
    |> Enum.into([])
  end

  defp start_monkeys(monkeys) do
    monkeys
    |> Enum.with_index()
    |> Enum.map(fn value -> Monkey.start_link(value) |> elem(1) end)
  end

  defp monkey_business(monkeys) do
    monkeys
    |> Enum.map(&Monkey.inspect/1)
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.reduce(&Kernel.*/2)
  end

  defp to_monkey([
         _,
         "Starting items: " <> items,
         "Operation: new = " <> operation,
         "Test: divisible by " <> test,
         "If true: throw to monkey " <> true_monkey,
         "If false: throw to monkey " <> false_monkey | _
       ]) do
    divisor = String.to_integer(test)

    %Monkey{
      items: Code.eval_string("[#{items}]") |> elem(0),
      operation: Code.eval_string("fn old -> #{operation} end") |> elem(0),
      divisor: divisor,
      test: fn number ->
        if Integer.mod(number, divisor) == 0,
          do: true_monkey |> String.to_integer() |> Monkey.throw_to(number),
          else: false_monkey |> String.to_integer() |> Monkey.throw_to(number)
      end
    }
  end
end
