defmodule Example.Worker do
  use GenServer

  alias Example.DefaultService

  def service() do
    Application.get_env(:example, :service, DefaultService)
  end

  def start_link(init_arg \\ []) do
    GenServer.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def get_foo() do
    GenServer.call(__MODULE__, :get_foo)
  end

  def initialise_foo() do
    pid = Process.whereis(__MODULE__)
    send(pid, :initialise_foo)
  end

  def init(_init_arg) do
    initial_state = "no foo for you"

    case service() do
      DefaultService ->
        {:ok, initial_state, {:continue, :get_foo_from_service}}

      _ ->
        {:ok, initial_state}
    end
  end

  def handle_continue(:get_foo_from_service, state) do
    send(self(), :initialise_foo)

    {:noreply, state}
  end

  def handle_info(:initialise_foo, _state) do
    IO.inspect("initialising foo now")
    new_state = service().foo()
    {:noreply, new_state}
  end

  def handle_call(:get_foo, _from, state) do
    {:reply, state, state}
  end
end
