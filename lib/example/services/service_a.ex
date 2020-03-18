defmodule Example.Services.ServiceA do
  @moduledoc """
  ServiceA provides a way to request data from external webserver

  The performance of ServiceA is somewhat sketchy... we don't know how long it
  takes to get data, sometimes the data is available, sometimes it's not, and
  sometimes the service doesn't even respond.
  """
  def foo() do
    Process.sleep(1000)
    "real service says foo"
  end
end
