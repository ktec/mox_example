defmodule Example.Service do
  def foo() do
    Process.sleep 1000
    IO.inspect "real service says foo", label: "Example.Service"
  end
end
