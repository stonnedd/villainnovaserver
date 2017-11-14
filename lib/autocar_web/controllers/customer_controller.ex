defmodule AutocarWeb.CustomerController do
  use AutocarWeb, :controller

  alias Autocar.Accounts
  alias Autocar.Accounts.Customer

  def index(conn, _params) do
    customers = Accounts.list_customers()
    render(conn, "index.html", customers: customers)
  end

  def new(conn, _params) do
    changeset = Accounts.change_customer(%Customer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"customer" => customer_params}) do
    case Accounts.create_customer(customer_params) do
      {:ok, customer} ->
        conn
        |> put_flash(:info, "Customer created successfully.")
        |> redirect(to: customer_path(conn, :show, customer))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def createcustomer(conn, %{"customer" => customer_params}) do
    case Accounts.create_customer(customer_params) do
      {:ok, customer} ->
        json conn |> put_status(:created), customer
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Accounts.get_customer!(id)
    render(conn, "show.html", customer: customer)
  end

  def showemail(conn, %{"email" => email})do
    email = Accounts.get_c_email(email)
    json conn, email
  end 

  def edit(conn, %{"id" => id}) do
    customer = Accounts.get_customer!(id)
    changeset = Accounts.change_customer(customer)
    render(conn, "edit.html", customer: customer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "customer" => customer_params}) do
    customer = Accounts.get_customer!(id)

    case Accounts.update_customer(customer, customer_params) do
      {:ok, customer} ->
        conn
        |> put_flash(:info, "Customer updated successfully.")
        |> redirect(to: customer_path(conn, :show, customer))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", customer: customer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Accounts.get_customer!(id)
    {:ok, _customer} = Accounts.delete_customer(customer)

    conn
    |> put_flash(:info, "Customer deleted successfully.")
    |> redirect(to: customer_path(conn, :index))
  end
end