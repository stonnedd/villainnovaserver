defmodule Autocar.Accounts do

  import Ecto.Query, warn: false
  alias Autocar.Repo

  alias Autocar.Accounts.Supplier

  def list_suppliers do
    Repo.all(Supplier)
  end

  def slcdservice(service)do
    Repo.all(from s in Supplier, where: s.service==^service)
  end

  def get_supplier!(id), do: Repo.get!(Supplier, id)

  def create_supplier(attrs \\ %{}) do
    %Supplier{}
    |> Supplier.changeset(attrs)
    |> Repo.insert()
  end

  def update_supplier(%Supplier{} = supplier, attrs) do
    supplier
    |> Supplier.changeset(attrs)
    |> Repo.update()
  end

  def delete_supplier(%Supplier{} = supplier) do
    Repo.delete(supplier)
  end

  def change_supplier(%Supplier{} = supplier) do
    Supplier.changeset(supplier, %{})
  end
end
