defmodule Autocar.Accounts do

  import Ecto.Query, warn: false

  alias Autocar.Repo
  alias Autocar.Accounts.{Supplier, Customer, User}
  #alias Autocar.Accounts.Customer
  
  def list_suppliers do
    Repo.all(Supplier)
  end

  def slcdservice(service)do
    Repo.all(from s in Supplier, where: s.service==^service)
  end

  def get_supplier!(id), do: Repo.get!(Supplier, id)

  def get_s_email(email) do
    Repo.all(from s in Supplier , where: s.email == ^email, select: s.email)
 end 

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

  #CUSTOMERS
  
  def list_customers do
    Repo.all(Customer)
  end

  def get_customer!(id), do: Repo.get!(Customer, id)

  def get_c_email(email) do
     Repo.all(from c in Customer , where: c.email == ^email, select: c.email)
  end 
 
  def create_customer(attrs \\ %{}) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end

  def update_customer(%Customer{} = customer, attrs) do
    customer
    |> Customer.changeset(attrs)
    |> Repo.update()
  end
  
  def delete_customer(%Customer{} = customer) do
    Repo.delete(customer)
  end
  
  def change_customer(%Customer{} = customer) do
    Customer.changeset(customer, %{})
  end

  #alias Autocar.Accounts.User

  @doc """
    Users
  """
  def list_users do
    Repo.all(User)
  end
  
  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def update_token(%User{} = user, token) do
    user
    |> User.changeset(%{token: token})
    |> Repo.update()
    IO.inspect "¨¨¨*******UPDATE TOKN;"
    IO.inspect user
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def get_user_by_token(token) do
    Repo.all(from c in User , where: c.token == ^token)
  end 

  def get_email(email) do
    Repo.all(from c in User , where: c.email == ^email, select: c.email)
  end 
end
