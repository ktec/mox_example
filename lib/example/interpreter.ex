defmodule Example.Interpreter do
  alias Example.Effect
  require Logger

  # def run(%Effect{m: m, f: f, a: a} = _effect) do
  #   timeout = 5000
  #
  #   task =
  #     Task.async(fn ->
  #       apply(m, f, a)
  #     end)
  #
  #   case Task.yield(task, timeout) || Task.shutdown(task) do
  #     {:ok, result} ->
  #       result
  #
  #     nil ->
  #       Logger.warn("Failed to get a result in #{timeout}ms")
  #       nil
  #   end
  # end

  def run(%Effect{m: nil, f: f, a: a} = _effect) do
    apply(f, a)
  end

  def run(%Effect{m: m, f: f, a: a} = _effect) do
    apply(m, f, a)
  end

  # def run(%Effect{m: m, f: f, a: a} = _effect) do
  #   IO.inspect effect, label: "real effect"
  # end
end
