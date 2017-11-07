defmodule Autocar.Catalogs.Mainservice do
  use Ecto.Schema
  import Ecto.Changeset
  alias Autocar.Catalogs.Mainservice


  schema "mainservices" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Mainservice{} = mainservice, attrs) do
    mainservice
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
