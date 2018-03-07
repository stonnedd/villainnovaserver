defmodule AutocarWeb.UserController do
  use AutocarWeb, :controller

  alias Autocar.Accounts
  alias Autocar.Accounts.User
  alias Autocar.CMS
  alias Autocar.CMS.Request

  def index(conn, _params) do
    users = Accounts.list_users()
    
    render(conn, "index.json", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create_user(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        json conn, user.id 
      {:error} ->
        json conn, nil
    end
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "User created successfully.")
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def get_customer_data(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    |> IO.inspect
    render(conn, "customer.json", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, _user} ->
        json conn, :updated
      {:error, _user} ->
        json conn, nil
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end

  def show_email(conn, %{"email" => email})do
    email = Accounts.get_email(email)
    json conn, email
  end
  
  def  get_user_by_token(conn, %{"token" => token})do
    user = Accounts.get_user_by_token(token)
    json conn, user
  end

  def get_user_by_id(conn, %{"id" => id}) do
    user = Accounts.get_user_by_id(id)
    json conn, user
  end

  def get_user_notifications(conn, %{"id" => id})do
    providers = Accounts.get_providers_ids_by_user_id(id)
    qty = Enum.reduce(providers, [], fn p, acc -> 
      acc ++ [CMS.get_quantity_requests_by_provider(p.provider_id)]
      |> IO.inspect
      end)
    rqts = CMS.get_quantity_requests_by_user_id(id)
    json conn, %{proposals: rqts, p_requests: Enum.sum(qty)} 
  end

  def show_full_data(conn, %{"id" => id}) do
    user = Accounts.get_full_data(id)
    |> IO.inspect
    render(conn, "show_full.json", user: user) 
  end

  def get_users_providers(conn, %{"id" => id}) do
    user = Accounts.get_users_providers(id)
    render(conn, "show_providers.json", user: user) 
  end


  def get_users_providers_ids(conn, %{"id"=>id})do
    ids = Accounts.get_providers_ids_by_user_id(id)
    json conn, ids
  end



end
