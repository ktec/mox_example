defmodule Example.Services.ServiceB do
  @moduledoc """
  ServiceB translates the data from ServiceA into something you can show to
  your users - but only if you give it the right information.

  Failure to provide the right info means it gets stuck for a few minutes,
  persumably searching some database or something, meanwhile, you're left
  hanging.
  """
  def bar(args) do
    case args do
      "real service says foo" ->
        "you get the cookie, well done"

      _ ->
        Process.sleep(1000)
        "Sorry but you need to give me something..."
    end
  end
end
