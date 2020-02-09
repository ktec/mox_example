defmodule Example.WorkerTest do
  use ExUnit.Case
  import Mox
  alias Example.Worker

  setup do
    Worker.initialise_foo()

    :ok
  end

  setup :verify_on_exit!

  describe "mocked service" do
    @tag :mocked_service
    test "returns mocked service foo" do
      Example.MockService
      |> expect(:foo, fn -> "mock says foo" end)
      |> allow(self(), Worker)

      assert Worker.get_foo() =~ ~s(mock says foo)
    end

    test "returns mocked service moo" do
      Example.MockService
      |> expect(:foo, fn -> "mock says moo" end)
      |> allow(self(), Worker)

      assert Worker.get_foo() =~ ~s(mock says moo)
    end
  end
end
