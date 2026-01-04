defmodule InventoryApi.Inventory.InventoryMovement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "inventory_movements" do
    field :quantity, :integer
    field :movement_type, :string

    belongs_to :item, InventoryApi.Inventory.Item

    timestamps(updated_at: false)
  end

  def changeset(movement, attrs) do
    movement
    |> cast(attrs, [:item_id, :quantity, :movement_type])
    |> validate_required([:item_id, :quantity, :movement_type])
    |> validate_inclusion(:movement_type, ["IN", "OUT", "ADJUSTMENT"])
  end
end
