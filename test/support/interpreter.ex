defmodule Test.Interpreter do
  alias Example.Effect
  def run(%Effect{} = effect) do
    IO.inspect effect, label: "test effect"
    effect
  end
end
