defmodule InventoryApiWeb.Router do
  use Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", InventoryApiWeb do
    pipe_through :api

    post "/items", ItemController, :create
    get "/items", ItemController, :index

    post "/movements", MovementController, :create
    get "/items/:item_id/movements", MovementController, :index
  end
end
