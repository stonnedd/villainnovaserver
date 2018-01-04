defmodule Autocar.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :service, :string
      add :comment, :string
      add :vehicle, :string
      add :lng, :float
      add :lat, :float
      add :status, :integer, default: 0
      add :provider, :integer
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()  
    end

    create index(:requests, [:user_id])
  end
end
