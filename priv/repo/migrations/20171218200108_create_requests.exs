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
      add :p_status, :integer, default: 0
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :provider_id, references(:providers, on_delete: :nothing)
      timestamps()  
    end

    create index(:requests, [:user_id])
  end
end
