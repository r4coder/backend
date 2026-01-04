defmodule InventoryApiWeb.MovementController do
  use InventoryApiWeb, :controller
  alias InventoryApi.Inventory

  def create(conn, params) do
    case Inventory.record_movement(params) do
      {:ok, movement} ->
        json(conn, movement)

      {:error, msg} ->
        conn |> put_status(400) |> json(%{error: msg})
    end
  end

  def index(conn, %{"item_id" => item_id}) do
    json(conn, Inventory.get_movements(item_id))
  end
end
