defmodule Example.Worker do
  use GenServer

  alias Example.DefaultService

  # @service Application.get_env(:example, :service, DefaultService)
  # @service DefaultService

  def service() do
    Application.get_env(:example, :service, DefaultService)
  end

  def start_link(init_arg \\ []) do
    GenServer.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def get_foo() do
    GenServer.call(__MODULE__, :get_foo)
  end

  def init(_init_arg) do
    initial_state = "no foo for you"
    {:ok, initial_state, {:continue, :get_foo_from_service}}
  end

  def handle_continue(:get_foo_from_service, _state) do
    # And here lies the problem. We want to call our service to get
    # whatever inital state it provides, but in doing so, we break
    # in the test environment because the MockService doesn't have
    # a function called `foo/0` until it can be defined in the expects
    # block within the test - by that time, this code has already
    # been executed because this GenServer is part of the staticly
    # defined supervision tree in `application.ex`.

    value_of_foo =
      if function_exported?(service(), :foo, 0) do
        service().foo()
      else
        "#{inspect(service())} does not support foo"
      end

    {:noreply, value_of_foo}
  end

  def handle_call(:get_foo, _from, state) do
    {:reply, state, state}
  end
end
