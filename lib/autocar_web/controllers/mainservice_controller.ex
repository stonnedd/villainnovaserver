defmodule AutocarWeb.MainserviceController do
  use AutocarWeb, :controller

  alias Autocar.Catalogs
  alias Autocar.Catalogs.Mainservice

  def mainservices(conn, _params) do
    mainservices = Catalogs.lst_mainservices()
    json conn, mainservices
  end

  def index(conn, _params) do
    mainservices = Catalogs.list_mainservices()
    render(conn, "index.html", mainservices: mainservices)
  end

  def new(conn, _params) do
    changeset = Catalogs.change_mainservice(%Mainservice{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"mainservice" => mainservice_params}) do
    case Catalogs.create_mainservice(mainservice_params) do
      {:ok, mainservice} ->
        conn
        |> put_flash(:info, "Mainservice created successfully.")
        |> redirect(to: mainservice_path(conn, :show, mainservice))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    mainservice = Catalogs.get_mainservice!(id)
    render(conn, "show.html", mainservice: mainservice)
  end

  def edit(conn, %{"id" => id}) do
    mainservice = Catalogs.get_mainservice!(id)
    changeset = Catalogs.change_mainservice(mainservice)
    render(conn, "edit.html", mainservice: mainservice, changeset: changeset)
  end

  def update(conn, %{"id" => id, "mainservice" => mainservice_params}) do
    mainservice = Catalogs.get_mainservice!(id)

    case Catalogs.update_mainservice(mainservice, mainservice_params) do
      {:ok, mainservice} ->
        conn
        |> put_flash(:info, "Mainservice updated successfully.")
        |> redirect(to: mainservice_path(conn, :show, mainservice))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", mainservice: mainservice, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    mainservice = Catalogs.get_mainservice!(id)
    {:ok, _mainservice} = Catalogs.delete_mainservice(mainservice)

    conn
    |> put_flash(:info, "Mainservice deleted successfully.")
    |> redirect(to: mainservice_path(conn, :index))
  end
end
