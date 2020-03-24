defmodule AST, do: defstruct(cmd: nil, next: nil)
defmodule GoNorth, do: defstruct([])
defmodule GoWest, do: defstruct([])
defmodule Wait, do: defstruct(seconds: nil)
defmodule SetCapslock, do: defstruct(set_caps: nil)
defmodule BuyItem, do: defstruct(cost: nil)
defmodule Print, do: defstruct(msg: nil)

defmodule DSL do
  defmacro __using__(_opts \\ []) do
    quote do
      require unquote(__MODULE__)
      import unquote(__MODULE__)
    end
  end

  defmacro with_npc(_name, do: expr) do
    {:__block__, [], lines} = expr

    quote do: list(unquote(lines))
  end

  defmacro with_ast(_name, do: {:__block__, [], lines}) do
    quote do: ast(unquote(lines))
  end

  def go_north, do: %GoNorth{}
  def go_west, do: %GoWest{}

  def wait_seconds(arg), do: %Wait{seconds: arg}
  def set_caps(arg), do: %SetCapslock{set_caps: arg}
  def print(arg), do: %Print{msg: arg}

  def list(lines) do
    Enum.map(lines, & &1)
  end

  def ast(lines) do
    List.foldr(lines, %AST{}, fn line, acc -> %AST{cmd: line, next: acc} end)
  end
end

defmodule Expede.Dog do
  use DSL

  def run() do
    with_npc :dog do
      go_north()
      wait_seconds(2)

      set_caps(true)
      print("Woof")
      set_caps(false)

      go_west()
      wait_seconds(1)
    end
  end

  def run2() do
    with_ast :dog do
      go_north()
      wait_seconds(2)

      set_caps(true)
      print("Woof")
      set_caps(false)

      go_west()
      wait_seconds(1)
    end
  end

  def out() do
    # tree version
    # %AST{
    #   cmd: %GoNorth{},
    #   next: AST{
    #     cmd: %Wait{seconds: 2},
    #     next: # ...
    # }

    # list version
    [
      %GoNorth{},
      %Wait{seconds: 2},
      %SetCapslock{set_caps: true},
      %Print{msg: "Woof"},
      %SetCapslock{set_caps: false},
      %GoWest{},
      %Wait{seconds: 1}
    ]
  end

  # text
  def handle_text(%Print{msg: msg}, _), do: IO.puts(msg)

  def handle_text(%SetCapslock{set_caps: is_caps}, state) do
    Agent.update(state, fn s -> %{s | is_capslock: is_caps} end)
  end

  def handle_text(not_text_cmd, _), do: not_text_cmd

  # Gameplay
  # ...
  def handle_gameplay(%BuyItem{}, _), do: :bought
  def handle_gameplay(not_gameplay_cmd, _), do: not_gameplay_cmd

  # Movement
  # ...
  def handle_movement(%GoNorth{}, _), do: :north
  def handle_movement(%GoWest{}, _), do: :west
  def handle_movement(not_movement_cmd, _), do: not_movement_cmd

  # Interpreter
  def interpreter(cmd, agent) do
    cmd
    |> handle_gameplay(agent)
    |> handle_movement(agent)
    |> handle_text(agent)
  end
end
