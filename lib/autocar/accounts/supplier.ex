defmodule Autocar.Accounts.Supplier do
  use Ecto.Schema
  import Ecto.Changeset
  alias Autocar.Accounts.Supplier


  schema "suppliers" do
    field :address, :string
    field :brands, :string
    field :email, :string
    field :lat, :float
    field :lng, :float
    field :manager, :string
    field :map_icon, :string
    field :name, :string
    field :phone, :integer
    field :phone_manager, :integer
    field :ranking, :integer
    field :schedule, :string
    field :service, :string
    field :specialty, :string
    field :website, :string
    field :password, :string
    timestamps()
  end

  @doc false
  def changeset(%Supplier{} = supplier, attrs) do
    supplier
    |> cast(attrs, [:name, :email, :service, :specialty, :brands, :address, :lat, :lng, :schedule, :phone, :website, :map_icon, :manager, :phone_manager, :ranking, :password])
    |> validate_required([])
    |> unique_constraint(:email)
  end
end
