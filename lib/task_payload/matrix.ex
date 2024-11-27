defmodule Matrix do
  @compile {:inline, generate_matrix_entry: 1}

  defp generate_matrix_entry(size) do
    :rand.uniform(size)
  end

  defp generate_matrix(size) do
    for _ <- 1..size do
      for _ <- 1..size, do: generate_matrix_entry(size)
    end
  end

  def generate_matrix_pairs(sizes) do
    Enum.map(sizes, fn size ->
      matrix_1 = generate_matrix(size)
      matrix_2 = generate_matrix(size)
      {matrix_1, matrix_2}
    end)
  end

  def multiply_matrix(matrix_a, matrix_b) do
    _size = length(matrix_a)

    transposed_b = transpose(matrix_b)

    matrix_a
    |> Enum.with_index()
    |> Enum.map(fn {row_a, _row_idx} ->
      Task.async(fn ->
        Enum.map(transposed_b, fn col_b ->
          dot_product(row_a, col_b)
        end)
      end)
    end)
    |> Enum.map(&Task.await/1)
  end

  defp dot_product(row_a, col_b) do
    row_a
    |> Enum.zip(col_b)
    |> Enum.reduce(0, fn {a, b}, acc -> acc + a * b end)
  end

  defp transpose(matrix) do
    matrix
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
