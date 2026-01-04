defmodule InventoryApi.Inventory.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :sku, :string
    field :unit, :string

    has_many :movements, InventoryApi.Inventory.InventoryMovement

    timestamps()
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :sku, :unit])
    |> validate_required([:name, :sku, :unit])
    |> unique_constraint(:sku)
  end
end
