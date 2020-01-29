defmodule Example.Worker do
  use GenServer

  alias Example.DefaultService

  def service do
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
    value_of_foo = service().foo()

    {:noreply, value_of_foo}
  end

  def handle_call(:get_foo, _from, state) do
    {:reply, state, state}
  end
end
