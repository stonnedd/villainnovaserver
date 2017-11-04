defmodule Autocar.Catalogs.Service do
  use Ecto.Schema
  import Ecto.Changeset
  alias Autocar.Catalogs.Service

  schema "services" do
    field :name, :string
    timestamps()
  end

  @doc false
  def changeset(%Service{} = service, attrs) do
    service
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
