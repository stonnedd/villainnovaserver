defmodule Autocar.CMS do
  
  import Ecto.Query, warn: false
  alias Autocar.Repo

  alias Autocar.CMS.Request
    
  def list_requests do
    Repo.all(Request)
  end

  def get_by_user(user_id)do
    query = from r in Request, 
    join: a in assoc(r, :attachment),
#    left_join: a in assoc(r, :attachment),
    where: r.user_id == ^user_id and r.status != 2,
    preload: [attachment: a],
    order_by: r.inserted_at
    Repo.all(query)
  end 

  def get_by_id(id)do
    query = from r in Request, 
    join: a in assoc(r, :attachment),
    where: r.id == ^id,
    preload: [attachment: a]
    Repo.all(query)
  end

  def get_by_provider(provider_id) do
    query = from r in Request, 
    join: a in assoc(r, :attachment),
    where: r.provider == ^provider_id,
    preload: [attachment: a]
    Repo.all(query)
  end

  ###
  
  def get_request!(id), do: Repo.get!(Request, id)

  
  def create_request(attrs \\ %{}) do
    IO.inspect "++++++++++++++++++++++++++++++++++++++"
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

  alias Autocar.CMS.Attachment

  @doc """
  Returns the list of attachments.

  ## Examples

      iex> list_attachments()
      [%Attachment{}, ...]

  """
  def list_attachments do
    Repo.all(Attachment)
  end

  @doc """
  ATTACHMENT
  """
  def get_attachment!(id), do: Repo.get!(Attachment, id)

  
  def create_attachment(attrs \\ %{}) do
    %Attachment{}
    |> Attachment.changeset(attrs)
    |> Repo.insert()
  end


  def update_attachment(%Attachment{} = attachment, attrs) do
    attachment
    |> Attachment.changeset(attrs)
    |> Repo.update()
  end

  
  def delete_attachment(%Attachment{} = attachment) do
    Repo.delete(attachment)
  end

 
  def change_attachment(%Attachment{} = attachment) do
    Attachment.changeset(attachment, %{})
  end
end
