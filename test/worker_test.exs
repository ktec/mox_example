defmodule Example.WorkerTest do
  use ExUnit.Case
  alias Example.Effect
  alias Example.Worker

  describe "default service" do
    test "returns default service foo" do
      assert Worker.get_foo() == %Effect{m: Example.Service, f: :foo, a: []}
    end
  end
end
