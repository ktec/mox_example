defmodule Example.DefaultService do
  @behaviour Example.ServiceBehaviour

  def foo() do
    "default service says foo"
  end
end
