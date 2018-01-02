defmodule Autocar.CMS.Request do
  use Ecto.Schema
  import Ecto.Changeset
  alias Autocar.CMS.Request
  alias Autocar.Accounts.User


  schema "requests" do
    field :comment, :string
    field :lat, :float
    field :lng, :float
    field :pic1, :binary
    field :pic2, :binary
    field :pic3, :binary
    field :pic_type, :string
    field :service, :string
    field :vehicle, :string
    field :status, :integer
    field :provider, :integer
    #field :user_id, :id
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Request{} = request, attrs) do
    request
    |> cast(attrs, [:service, :comment, :pic1, :pic2, :pic3, :pic_type, :vehicle, :lng, :lat, :status, :user_id, :provider])
    |> validate_required([:service, :comment])
    |> unique_constraint(:user_id)
  end
end
