defmodule Autocar.CMS.Attachment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Autocar.CMS.{Attachment, Request}


  schema "attachments" do
    field :url_pic1, :string
    field :url_pic2, :string
    field :url_pic3, :string
    belongs_to :request, Request
    timestamps()
  end

  @doc false
  def changeset(%Attachment{} = attachment, attrs) do
    attachment
    |> cast(attrs, [:url_pic1, :url_pic2, :url_pic3, :request_id])
    |> validate_required([])
  end
end
