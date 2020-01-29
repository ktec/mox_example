defmodule Example.WorkerTest do
  use ExUnit.Case
  import Mox
  alias Example.Worker

  describe "default service" do
    test "returns default service foo" do
      assert Worker.get_foo() =~ ~s(default says foo)
    end
  end

  describe "mocked service" do
    setup do
      # Normally you would add this to `test_helper.ex`, or `support/mocks.ex
      Mox.defmock(Example.MockService, for: Example.ServiceBehaviour)

      Example.MockService
      |> expect(:foo, fn -> "setup all says foo" end)

      :ok
    end

    setup :verify_on_exit!

    test "returns mocked service foo" do
      Example.MockService
      |> expect(:foo, fn -> "mock says foo" end)
      |> allow(self(), Process.whereis(Worker))

      assert Worker.get_foo() =~ ~s(mock says foo)
    end
  end
end
