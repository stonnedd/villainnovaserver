defmodule Autocar.Accounts.Supplier do
  use Ecto.Schema
  import Ecto.Changeset
  alias Autocar.Accounts.Supplier


  schema "suppliers" do
    field :places_name, :string
    field :address, :string
    field :brands, :string
    field :email, :string
    field :lat, :float
    field :lng, :float
    field :map_icon, :string
    field :aditional_phone, :string
    field :ranking, :integer
    field :schedule, :string
    field :service, :string
    field :specialty, :string
    field :website, :string
    field :is_active, :boolean
    timestamps()
  end

  @doc false
  def changeset(%Supplier{} = supplier, attrs) do
    supplier
    |> cast(attrs, [:email, :service, :specialty, :brands, :address, :lat, :lng, :schedule, :map_icon, :manager, :phone_manager, :ranking, :website, :is_active])
    |> validate_required([])
    |> unique_constraint(:email)
  end
end
