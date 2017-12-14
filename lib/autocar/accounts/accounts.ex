defmodule Autocar.Accounts do

  import Ecto.Query, warn: false

  alias Autocar.Repo
  alias Autocar.Accounts.{Supplier, User, Provider}
  
  def list_suppliers do
    Repo.all(Supplier)
  end

  def slcdservice(service)do
    Repo.all(from s in Supplier, where: s.service==^service)
  end

  def get_supplier!(id) do
     Repo.get!(Supplier, id)
  end 

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

  
  def list_users do
    User
    |>Repo.all()
    |>Repo.preload([:providers])
    
  end
  
  def get_user!(id) do
   User
    |>Repo.get!(id)
  end   

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
#    |> Ecto.Changeset.cast_assoc(:providers, with: &Provider.changeset/2)
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

  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def get_user_by_token(token) do
     query = from u in User, 
      where: u.token == ^token,
      select: %{id: u.id, name: u.name, email: u.email, phone: u.phone, profile: u.profile}
      Repo.all(query) 
  end 

  def get_user_by_id(id) do
    # query = (from u in User, where: u.id == ^id)
    # |> Repo.all()     
    # |> Repo.preload(:providers)

    query = from u in User, 
      where: u.id == ^id,
      select: %{id: u.id, name: u.name, email: u.email, phone: u.phone, profile: u.profile}
    Repo.all(query) 
    
 end 


  def get_email(email) do
    Repo.all(from c in User , where: c.email == ^email, select: c.email)
  end 


  ## PROVIDER


  def list_providers do
    Repo.all(Provider)
  end

  def user_provider(user_id) do
    query = from p in Provider, 
      where: p.user_id == ^user_id 
    Repo.all(query)
  end 

  def get_provider!(id) do
     Repo.get!(Provider, id)
  end

  def get_pro_by_svc(service) do
    query = from p in Provider,
      where: p.service == ^service
    Repo.all(query)
  end 

 
  def create_provider(attrs \\ %{}) do
    
     %Provider{}
     |> Provider.changeset(attrs)
     #|> Repo.preload(:user)
     #|> Ecto.Changeset.cast_assoc(:user, with: &User.changeset/2)
     |> Repo.insert()
    
  end

  def update_provider(%Provider{} = provider, attrs) do
    provider
    |> Provider.changeset(attrs)
    |> Repo.update()
  end

  
  def delete_provider(%Provider{} = provider) do
    Repo.delete(provider)
  end

  def change_provider(%Provider{} = provider) do
    Provider.changeset(provider, %{})
  end
end
