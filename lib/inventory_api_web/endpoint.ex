defmodule InventoryApiWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :inventory_api

  plug Plug.Logger
  plug Plug.Parsers,
    parsers: [:json],
    json_decoder: Jason

  plug InventoryApiWeb.Router
end
