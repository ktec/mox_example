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

  defmacro effect(expr) do
    expr =
      case expr do
        [do: expr] -> expr
        expr -> expr
      end

    IO.inspect(expr, label: "expr")

    case expr do
      {{_, _, [{_, _, mod}, f]}, _, args} ->
        m = Module.concat(mod)

        quote bind_quoted: [m: m, f: f, args: args] do
          Effect.new(m, f, args)
        end

      {m, _, [{_f, _, [[], args]}]} ->
        # {f, args} = Code.eval_quoted(expr)
        f = expr

        quote bind_quoted: [m: m, f: f, args: args] do
          Effect.new(nil, f, args)
        end

        # {f, _, args} ->
        #   m = Macro.escape(__CALLER__)
        #
        #   quote bind_quoted: [m: m, f: f, args: args] do
        #     Effect.new(m, f, args)
        #   end
    end
  end

  defmacro __using__(_opts \\ []) do
    quote do
      require Effect
      import Effect
    end
  end
end
