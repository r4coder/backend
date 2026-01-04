defmodule InventoryApi.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias InventoryApi.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      setup do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
      end
    end
  end
end
