# Змінні

x = 10
IO.puts("Початкове значення: #{x}")

x = x + 5
IO.puts("Перезаписане значення: #{x}")

# 2 Функції та модулі

add = fn a, b -> a + b end

defmodule Math do
  def add(a, b) do
    a + b
  end
end

IO.puts("Анонімна функція: #{add.(1, 2)}")

IO.puts("Функція з модуля: #{Math.add(2, 3)}")

# 3 Рекурсія

defmodule Factorial do
  def calc(0), do: 1
  def calc(n), do: n * calc(n - 1)
end

IO.puts("Обчислення факторіалу 5: #{Factorial.calc(5)}")

# 4 Модуль Task

task = Task.async(fn -> 2 + 2 end)
result = Task.await(task)
IO.puts("Результат асинхронного завдання: #{result}")

# 5 Модуль GenServer

defmodule KeyValueStore do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def put(key, value) do
    GenServer.cast(__MODULE__, {:put, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def init(state), do: {:ok, state}

  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end
end

{:ok, _pid} = KeyValueStore.start_link([])

KeyValueStore.put(:a, 123)

IO.puts("Значення з внутрішнього стану GenServer: #{KeyValueStore.get(:a)}")
