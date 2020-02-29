defmodule Product do
  @default_name "default"

  @type t :: %{
          id: integer,
          name: binary
        }

  defstruct [:id, :name]

  def new(id), do: %__MODULE__{id: id, name: @default_name}
end
