defmodule Autocar.Repo.Migrations.CreateAttachments do
  use Ecto.Migration

  def change do
    create table(:attachments) do
      add :url_pic1, :string
      add :url_pic2, :string
      add :url_pic3, :string
      add :request_id, references(:requests, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:attachments, [:request_id])
  end
end
