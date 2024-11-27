defmodule Benchmarks.TaskQueueBenchmark.Matrix do
  def run do
    Benchee.run(
      %{
        "SingleProcessTaskQueue.Matrix" => fn input ->
          SingleProcessTaskQueue.Matrix.process(input)
        end,
        "MultiProcessTaskQueue.Matrix" => fn input ->
          MultiProcessTaskQueue.Matrix.process(input)
        end,
        "MultiProcessLimitedTaskQueue.Matrix" => fn input ->
          MultiProcessLimitedTaskQueue.Matrix.process(input)
        end
      },
      inputs: %{
        "(100x100)x1" => Matrix.generate_matrix_pairs(Enum.take_random(1..100, 1)),
        "(100x100)x10" => Matrix.generate_matrix_pairs(Enum.take_random(1..100, 10)),
        "(100x100)x50" => Matrix.generate_matrix_pairs(Enum.take_random(1..100, 50)),
        "(100x100)x100" => Matrix.generate_matrix_pairs(Enum.take_random(1..100, 100)),
        "(100x100)x200" => Matrix.generate_matrix_pairs(Enum.take_random(1..100, 200))
      }
    )
  end
end

defmodule Benchmarks do
  def run do
    Benchmarks.TaskQueueBenchmark.Matrix.run()
  end
end
