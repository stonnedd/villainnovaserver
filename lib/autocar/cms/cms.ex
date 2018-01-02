defmodule Autocar.CMS do
  
  import Ecto.Query, warn: false
  alias Autocar.Repo

  alias Autocar.CMS.Request
  #alias Autocar.Accounts.User

  
  def list_requests do
    Repo.all(Request)
  end

  def get_by_user(user_id)do
    query = from r in Request, 
    where: r.user_id == ^user_id 
    Repo.all(query)
  end
  ###
  def get_request!(id) do
    Request
     |> Repo.get!(Request, id)
     |> Repo.preload(:user)
  end

  
  def create_request(attrs \\ %{}) do
    %Request{}
    |> Request.changeset(attrs)
    |> Repo.insert()
  end

  
  def update_request(%Request{} = request, attrs) do
    request
    |> Request.changeset(attrs)
    |> Repo.update()
  end

 
  def delete_request(%Request{} = request) do
    Repo.delete(request)
  end

  
  def change_request(%Request{} = request) do
    Request.changeset(request, %{})
  end
end
