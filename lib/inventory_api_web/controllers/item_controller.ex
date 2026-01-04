defmodule InventoryApiWeb.ItemController do
  use InventoryApiWeb, :controller
  alias InventoryApi.Inventory

  def create(conn, params) do
    case Inventory.create_item(params) do
      {:ok, item} ->
        json(conn, item)

      {:error, changeset} ->
        conn |> put_status(400) |> json(changeset)
    end
  end

  def index(conn, _params) do
    json(conn, Inventory.list_items_with_stock())
  end
end
