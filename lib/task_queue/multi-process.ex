defmodule MultiProcessTaskQueue.Matrix do
  def process(data) do
    data
    |> Enum.map(&Task.async(fn -> Matrix.multiply_matrix(elem(&1, 0), elem(&1, 1)) end))
    |> Enum.map(&Task.await/1)
  end
end
