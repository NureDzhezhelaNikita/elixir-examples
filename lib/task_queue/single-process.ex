defmodule SingleProcessTaskQueue.Matrix do
  def process(data) do
    Enum.map(data, &Matrix.multiply_matrix(elem(&1, 0), elem(&1, 1)))
  end
end
