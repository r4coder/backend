defmodule InventoryApi.Repo.Migrations.CreateInventoryMovements do
  use Ecto.Migration

  def change do
    create table(:inventory_movements) do
      add :item_id, references(:items, on_delete: :delete_all)
      add :quantity, :integer, null: false
      add :movement_type, :string, null: false
      timestamps(updated_at: false)
    end
  end
end
