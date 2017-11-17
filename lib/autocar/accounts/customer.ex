defmodule Autocar.Accounts.Customer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Autocar.Accounts.Customer


  schema "customers" do
    field :email, :string
    field :name, :string
    field :password, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(%Customer{} = customer, attrs) do
    customer
    |> cast(attrs, [:name, :email, :phone, :password])
    |> validate_required([:name, :email, :phone, :password])
    |> unique_constraint(:email)
  end
end
