defmodule Autocar.Catalogs do
  @moduledoc """
  The Catalogs context.
  """

  import Ecto.Query, warn: false
  alias Autocar.Repo
  alias Autocar.Catalogs.Service

  def list_services do
    Repo.all(Service)
  end

  def lst_services do
    Repo.all(from s in Service, select: s.name)
  end

  def get_service!(id), do: Repo.get!(Service, id)

  def create_service(attrs \\ %{}) do
    %Service{}
    |> Service.changeset(attrs)
    |> Repo.insert()
  end

  def update_service(%Service{} = service, attrs) do
    service
    |> Service.changeset(attrs)
    |> Repo.update()
  end

  def delete_service(%Service{} = service) do
    Repo.delete(service)
  end

  def change_service(%Service{} = service) do
    Service.changeset(service, %{})
  end

  alias Autocar.Catalogs.Mainservice


  def list_mainservices do
    Repo.all(Mainservice)
  end


  def get_mainservice!(id), do: Repo.get!(Mainservice, id)


  def create_mainservice(attrs \\ %{}) do
    %Mainservice{}
    |> Mainservice.changeset(attrs)
    |> Repo.insert()
  end

  def update_mainservice(%Mainservice{} = mainservice, attrs) do
    mainservice
    |> Mainservice.changeset(attrs)
    |> Repo.update()
  end

  def delete_mainservice(%Mainservice{} = mainservice) do
    Repo.delete(mainservice)
  end


  def change_mainservice(%Mainservice{} = mainservice) do
    Mainservice.changeset(mainservice, %{})
  end
end
