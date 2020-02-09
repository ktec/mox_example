defmodule Example.WorkerTest do
  use ExUnit.Case
  alias Example.Worker

  # In order to have the Worker use the test services we need to restart
  # the process; killing it will suffice as it is a supervised process
  def restart_worker() do
    pid = Process.whereis(Worker)
    Process.exit(pid, :kill)
    Process.sleep(10)
  end

  describe "mocked service" do
    test "returns mocked service foo" do
      Application.put_env(:example, :service, Test1Service)

      restart_worker()

      assert Worker.get_foo() =~ ~s(test 1 says foo)
    end

    test "returns mocked service moo" do
      Application.put_env(:example, :service, Test2Service)

      restart_worker()

      assert Worker.get_foo() =~ ~s(test 2 says moo)
    end
  end
end
