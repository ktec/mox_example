defmodule Example.Interpreter do
  alias Example.Effect
  def run(%Effect{m: m, f: f, a: a} = _effect) do
    # IO.inspect effect, label: "real effect"
    apply(m, f, a)
  end
end
