defmodule Example.Services.Database do
  @moduledoc """
  Database service provide way to save and retreive values from a persistant
  store
  """

  @spec get(integer) :: Product.t() | nil
  def get(id) do
    Process.sleep(1000)

    case id do
      1 ->
        Product.new(1)

      _ ->
        nil
    end
  end

  @spec update(Product.t() | any) :: :ok | :error
  def update(%Product{id: id}) do
    if id == 1 do
      :ok
    else
      :error
    end
  end
end
