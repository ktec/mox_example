defmodule Example.WorkerTest do
  use ExUnit.Case
  alias Example.Effect
  alias Example.Worker
  alias Example.Services

  describe "default service" do
    test "returns default service foo" do
      assert Worker.get_foo() == Effect.new(Services.ServiceA, :foo)
    end

    test "returns the value of bar" do
      assert Worker.get_bar() ==
               Effect.new(Services.ServiceB, :bar, [Effect.new(Services.ServiceA, :foo)])
    end
  end

  describe "tests" do
    @tag :wip
    test "it works" do
      expected_effect = %Example.Effect{
        m: Example.Services.Database,
        f: :update,
        a: [%Product{id: 1, name: "luxury product"}]
      }

      assert Worker.update_product(1, "luxury product") == expected_effect
    end
  end
end
