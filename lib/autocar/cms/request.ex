defmodule Autocar.CMS.Request do
  use Ecto.Schema
  import Ecto.Changeset
  alias Autocar.CMS.{Request, Attachment}
  alias Autocar.Accounts.{User, Provider}


  schema "requests" do
    field :comment, :string
    field :lat, :float
    field :lng, :float
    field :service, :string
    field :vehicle, :string
    field :status, :integer
    field :p_status, :integer
    belongs_to :user, User
    belongs_to :provider, Provider
    has_one :attachment, Attachment

    timestamps()
  end

  @doc false
  def changeset(%Request{} = request, attrs) do
    request
    |> cast(attrs, [:service, :comment, :vehicle, :lng, :lat, :status, :user_id, :provider_id, :p_status])
    |> validate_required([:service, :comment])
    |> unique_constraint(:user_id)
  end
end
