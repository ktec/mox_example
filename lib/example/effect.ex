defmodule Example.Effect do
  @moduledoc """
  Module for describing side effects

  Rather than litter the code with real side effects, why not place
  descriptions of those side effects. Code is data, data is code, let the
  side effects become the data.
  """

  alias __MODULE__

  @type t :: %{m: module, f: atom, a: [any]}

  defstruct [:m, :f, :a]

  def new(m, f, a \\ []), do: %__MODULE__{m: m, f: f, a: List.wrap(a)}

  defmacro effect(block) do
    {{_, _, [{_, _, mod}, f]}, _, args} = block

    m = Module.concat(mod)

    quote bind_quoted: [m: m, f: f, args: args] do
      Effect.new(m, f, args)
    end
  end

  defmacro __using__(_opts \\ []) do
    quote do
      require Effect
      import Effect
    end
  end
end
