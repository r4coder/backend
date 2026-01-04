defmodule InventoryApi.InventoryTest do
  use InventoryApi.DataCase
  alias InventoryApi.Inventory

  test "stock calculation works" do
    {:ok, item} =
      Inventory.create_item(%{name: "Pen", sku: "P001", unit: "pcs"})

    Inventory.record_movement(%{
      "item_id" => item.id,
      "quantity" => 10,
      "movement_type" => "IN"
    })

    Inventory.record_movement(%{
      "item_id" => item.id,
      "quantity" => 3,
      "movement_type" => "OUT"
    })

    assert Inventory.get_stock(item.id) == 7
  end

  test "negative stock is rejected" do
    {:ok, item} =
      Inventory.create_item(%{name: "Book", sku: "B001", unit: "pcs"})

    Inventory.record_movement(%{
      "item_id" => item.id,
      "quantity" => 5,
      "movement_type" => "IN"
    })

    result =
      Inventory.record_movement(%{
        "item_id" => item.id,
        "quantity" => 10,
        "movement_type" => "OUT"
      })

    assert {:error, "Negative stock not allowed"} = result
  end
end
