defmodule InventoryApi.Inventory do
  import Ecto.Query
  alias InventoryApi.Repo
  alias InventoryApi.Inventory.{Item, InventoryMovement}

  def create_item(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  def record_movement(attrs) do
    item_id = attrs["item_id"]
    current_stock = get_stock(item_id)
    delta = movement_delta(attrs)

    if current_stock + delta < 0 do
      {:error, "Negative stock not allowed"}
    else
      %InventoryMovement{}
      |> InventoryMovement.changeset(attrs)
      |> Repo.insert()
    end
  end

  def list_items_with_stock do
    Repo.all(Item)
    |> Enum.map(fn item ->
      Map.put(item, :stock, get_stock(item.id))
    end)
  end

  def get_movements(item_id) do
    Repo.all(
      from m in InventoryMovement,
      where: m.item_id == ^item_id,
      order_by: [desc: m.inserted_at]
    )
  end

  def get_stock(item_id) do
    Repo.all(
      from m in InventoryMovement,
      where: m.item_id == ^item_id,
      select: {m.movement_type, m.quantity}
    )
    |> Enum.reduce(0, fn
      {"IN", q}, acc -> acc + q
      {"OUT", q}, acc -> acc - q
      {"ADJUSTMENT", q}, acc -> acc + q
    end)
  end

  defp movement_delta(%{"movement_type" => "IN", "quantity" => q}), do: q
  defp movement_delta(%{"movement_type" => "OUT", "quantity" => q}), do: -q
  defp movement_delta(%{"movement_type" => "ADJUSTMENT", "quantity" => q}), do: q
end
