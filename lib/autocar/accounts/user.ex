defmodule Autocar.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Autocar.Accounts.{User, Provider}
  alias Autocar.CMS.Request
  alias Comeonin.Bcrypt

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string
    field :phone, :string
    field :profile, :string
    field :token, :string, size: 512
    has_many :providers, Provider
    has_many :requests, Request

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :phone, :profile, :token])
    |> validate_required([:email, :password, :profile])
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
