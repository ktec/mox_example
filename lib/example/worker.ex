defmodule Example.Worker do
  use GenServer

  use Example.Effect

  @interpretor Application.get_env(:example, :interpretor, Example.Interpreter)

  def start_link(init_arg \\ []) do
    GenServer.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def get_foo() do
    GenServer.call(__MODULE__, :get_foo)
  end

  def get_bar() do
    GenServer.call(__MODULE__, :get_bar)
  end

  def init(_init_arg) do
    initial_state = "no foo for you"
    {:ok, initial_state, {:continue, :get_foo_from_service}}
  end

  def handle_continue(:get_foo_from_service, _state) do
    # SIDE EFFECT HERE!!!
    # value_of_foo = @interpretor.run(Effect.new(Services.ServiceA, :foo))
    s1 = effect(Example.Services.ServiceA.foo())
    value_of_foo = @interpretor.run(s1)

    {:noreply, value_of_foo}
  end

  def handle_call(:get_foo, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:get_bar, _from, state) do
    # SIDE EFFECT HERE!!!
    # value_of_bar = @interpretor.run(Effect.new(Services.ServiceB, :bar, state))
    s1 = effect(Example.Services.ServiceB.bar(state))

    value_of_bar = @interpretor.run(s1)

    {:reply, value_of_bar, state}
  end

  # Non-GenServer functions

  def update_product(id, new_name) do
    # SIDE EFFECT!
    # product = Services.Database.get(id)
    # product = @interpretor.run(Effect.new(Services.Database, :get, id))
    s1 = effect(Example.Services.Database.get(id))

    # TODO: Running s1 will return either a Product, or a nil. The existing
    # side effect doesn't do anything to acknowledge this fact.
    product = @interpretor.run(s1)

    # Functional core!
    updated_product = %Product{product | name: new_name}

    # SIDE EFFECT!
    # Services.Database.update(updated_product)
    s2 = effect(Example.Services.Database.update(updated_product))

    # _product = @interpretor.run(Effect.new(Services.Database, :update, updated_product))
    _product = @interpretor.run(s2)
  end

  def get_data() do
    s1 = effect(Example.Services.Http.fetch())
    i1 = Application.get_env(:example, :interpretor2, Example.Interpreter)

    case i1.run(s1) do
      {:ok, _headers, body} -> body
      {:error, reason} -> reason
    end
  end
end
