defmodule Example.WorkerTest do
  use ExUnit.Case
  use Example.Effect
  alias Example.{Effect, Worker, Services}

  describe "default service" do
    test "returns default service foo" do
      assert Worker.get_foo() == Effect.new(Services.ServiceA, :foo)
    end

    test "returns the value of bar" do
      assert Worker.get_bar() ==
               Effect.new(Services.ServiceB, :bar, [Effect.new(Services.ServiceA, :foo)])
    end
  end

  describe "update_product/2" do
    test "it works" do
      expected_effect = %Effect{
        m: Services.Database,
        f: :update,
        a: [%Product{id: 1, name: "luxury product"}]
      }

      assert Worker.update_product(1, "luxury product") == expected_effect
    end
  end

  describe "get_data/0" do
    test "it works" do
      defmodule TestSuccess do
        def run(%Effect{f: :fetch, m: Services.Http}) do
          {:ok, [], "here is result 2"}
        end
      end

      Application.put_env(:example, :interpretor2, TestSuccess)

      expected_effect = "here is result 2"

      assert Worker.get_data() == expected_effect
    end

    test "it fails" do
      defmodule TestFailure do
        def run(%Effect{f: :fetch, m: Services.Http}) do
          {:error, "There was an error"}
        end
      end

      Application.put_env(:example, :interpretor2, TestFailure)

      expected_effect = "There was an error"

      assert Worker.get_data() == expected_effect
    end
  end
end
