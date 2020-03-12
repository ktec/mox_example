defmodule Test.Interpreter do
  alias Example.Effect

  def run(%Effect{a: [1], f: :get, m: Example.Services.Database}) do
    Product.new(1)
  end

  def run(%Effect{a: _, f: :get, m: Example.Services.Database}) do
    nil
  end

  def run(%Effect{} = effect) do
    # IO.inspect(effect, label: "test effect")
    effect
  end
end
