defmodule Autocar.CMS.Proposal do
  use Ecto.Schema
  import Ecto.Changeset
  alias Autocar.CMS.{Proposal, Request}


  schema "proposals" do
    field :c_status, :integer
    field :comment, :string
    field :p_status, :integer
    field :price, :integer
    field :time, :string
    # field :request_id, :id
    belongs_to :request, Request
    timestamps()
  end

  @doc false
  def changeset(%Proposal{} = proposal, attrs) do
    proposal
    |> cast(attrs, [:price, :time, :comment, :c_status, :p_status, :request_id])
    |> validate_required([:price, :time])
  end
end
