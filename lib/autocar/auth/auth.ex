defmodule Autocar.Auth do

    import Ecto.Query, warn: false
    
    alias Autocar.Repo
    alias Autocar.Accounts
    alias Autocar.Accounts.{Supplier, Customer, User}
    alias Comeonin.Bcrypt


    def get_customer(email) do
        Repo.get_by(Customer, email: email)
    end

    def get_supplier(email) do
        Repo.get_by(Supplier, email: email)
    end

    def get_user!(id), do: Repo.get!(User, id)
    
    def authenticate_user(email, plain_text_password) do
        query = from u in User, where: u.email == ^email
        Repo.one(query)
        |> check_password(plain_text_password)
    end

    def update_token(token, email) do
        query = from u in User, where: u.email == ^email
        Repo.one(query)
        |> Accounts.update_token(token)
    end

    defp check_password(nil, _), do: {:error, "Incorrect username or password"}
    defp check_password(user, plain_text_password) do
      case Bcrypt.checkpw(plain_text_password, user.password) do
        true -> {:ok, user}
        false -> {:error, nil}
      end
    end

end