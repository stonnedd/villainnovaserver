defmodule Autocar.Accounts.Provider do
  use Ecto.Schema
  import Ecto.Changeset
  alias Autocar.Accounts.{Provider, User}

  schema "providers" do
    field :address, :string
    field :aditional_phone, :string
    field :brands, :string
    field :company_name, :string
    field :is_active, :boolean, default: false
    field :lat, :float
    field :lng, :float
    field :map_icon, :string
    field :ranking, :float
    field :schedule, :string
    field :service, :string
    field :specialty, :string
    field :website, :string
    belongs_to :user, User, foreign_key: :user_id 

    timestamps()
  end

  @doc false
  def changeset(%Provider{} = provider, attrs) do
    provider
    |> cast(attrs, [:company_name, :address, :brands, :lat, :lng, :map_icon, :aditional_phone, :ranking, :schedule, :service, :specialty, :website, :is_active, :user_id])
    |> validate_required([])
    #|> validate_required([:company_name, :address, :brands, :lat, :lng, :map_icon, :aditional_phone, :ranking, :schedule, :service, :specialty, :website, :is_active])
  end
  
  # @requiered_fields ~w(company_name address brands lat lng map_icon aditional_phone ranking schedule service specialty website is_active user_id)

  # def changeset(model, params \\ :empty) do
  #   model
  #   |> cast(params, @requiered_fields)
  # end

end