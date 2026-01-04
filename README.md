# Inventory Management Backend

A JSON API built using **Elixir + Phoenix** with **PostgreSQL** for managing inventory items and their stock through inventory movements.

The backend focuses on correctness, clean domain logic, and clear separation of concerns.

---

## Tech Stack

- Elixir
- Phoenix (API-only)
- Ecto
- PostgreSQL
- ExUnit (testing)

---

## Data Model

### Item
Represents a product in the inventory.

| Field | Description |
|------|------------|
| id | Primary key |
| name | Item name |
| sku | Unique identifier |
| unit | Unit of measurement (pcs / kg / litre) |

---

### Inventory Movement
Represents a change in stock for an item.

| Field | Description |
|------|------------|
| item_id | Reference to Item |
| quantity | Quantity moved |
| movement_type | IN / OUT / ADJUSTMENT |
| created_at | Timestamp |

---

## Stock Calculation Logic

Stock is **not stored** in the database.

It is calculated dynamically using inventory movements:


### Business Rules
- Every stock change is recorded as a movement
- Current stock is derived by aggregating movement history
- **Negative stock is not allowed**
- Any movement resulting in negative stock is rejected with a clear error message

This ensures accuracy, auditability, and prevents inconsistent data.

---

## API Endpoints

- `POST /api/items` – Create a new item
- `GET /api/items` – Fetch all items with current stock
- `POST /api/movements` – Record an inventory movement
- `GET /api/items/:item_id/movements` – Fetch movement history for an item

---

## How to Run

### Prerequisites
- Elixir installed
- PostgreSQL running

### Setup

```bash
mix deps.get
mix ecto.create
mix ecto.migrate
mix test
mix phx.server

