defmodule MultiProcessLimitedTaskQueue.Matrix do
  def process(data) do
    data
    |> Task.async_stream(
      fn {matrix_a, matrix_b} ->
        Matrix.multiply_matrix(matrix_a, matrix_b)
      end
    )
    |> Enum.map(fn
      {:ok, result} -> result
    end)
  end
end
