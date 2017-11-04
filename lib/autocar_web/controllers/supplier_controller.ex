defmodule AutocarWeb.SupplierController do
  use AutocarWeb, :controller

  alias Autocar.Accounts
  alias Autocar.Accounts.Supplier

  def index(conn, _params) do
    suppliers = Accounts.list_suppliers()
    render(conn, "index.html", suppliers: suppliers)
  end

  def new(conn, _params) do
    changeset = Accounts.change_supplier(%Supplier{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"supplier" => supplier_params}) do
    case Accounts.create_supplier(supplier_params) do
      {:ok, supplier} ->
        conn
        |> put_flash(:info, "Supplier created successfully.")
        |> redirect(to: supplier_path(conn, :show, supplier))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # def createsupplier(conn, %{"supplier" => supplier_params}) do
  #   with {:ok, %Supplier{} = supplier} <- Accounts.create_supplier(supplier_params) do
  #     conn 
  #     |> put_status(:created)
  #     |> put_resp_header("location", supplier_path(conn, :show, supplier))
  #     |> render("show.json", supplier_params: supplier)
  #   end
  # end

  def createsupplier(conn, %{"supplier" => supplier_params}) do
    case Accounts.create_supplier(supplier_params) do
      {:ok, supplier} ->
        json conn |> put_status(:created), supplier
        #|> put_resp_header("location", supplier_path(conn, :show, supplier))
    end
  end

  def show(conn, %{"id" => id}) do
    supplier = Accounts.get_supplier!(id)
    render(conn, "show.html", supplier: supplier)
  end

  def allsuppliers(conn, _params) do
    suppliers = Accounts.list_suppliers()
    #render(conn, "index.json", suppliers: suppliers)
    json conn, suppliers
  end

  def selectedservice(conn, %{"service" => service})do
    suppliers = Accounts.slcdservice(service)
    json conn, suppliers
  end   

  def edit(conn, %{"id" => id}) do
    supplier = Accounts.get_supplier!(id)
    changeset = Accounts.change_supplier(supplier)
    render(conn, "edit.html", supplier: supplier, changeset: changeset)
  end

  def update(conn, %{"id" => id, "supplier" => supplier_params}) do
    supplier = Accounts.get_supplier!(id)

    case Accounts.update_supplier(supplier, supplier_params) do
      {:ok, supplier} ->
        conn
        |> put_flash(:info, "Supplier updated successfully.")
        |> redirect(to: supplier_path(conn, :show, supplier))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", supplier: supplier, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    supplier = Accounts.get_supplier!(id)
    {:ok, _supplier} = Accounts.delete_supplier(supplier)

    conn
    |> put_flash(:info, "Supplier deleted successfully.")
    |> redirect(to: supplier_path(conn, :index))
  end
end
