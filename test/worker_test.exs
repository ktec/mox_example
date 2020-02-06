defmodule Example.WorkerTest do
  use ExUnit.Case
  import Mox
  alias Example.Worker

  setup :verify_on_exit!

  describe "mocked service" do
    # We have to set Mox to global because we would have an impossible chicken
    # and egg situation wtih Mox.allow/2 and Worker.start_link/0
    setup :set_mox_global

    test "returns mocked service foo" do
      Example.MockService
      |> expect(:foo, fn -> "mock says foo" end)

      Worker.start_link()

      assert Worker.get_foo() =~ ~s(mock says foo)
    end
  end
end
