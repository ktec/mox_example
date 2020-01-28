defmodule Example.ServiceBehaviour do
  @callback foo() :: :ok | binary()
end
