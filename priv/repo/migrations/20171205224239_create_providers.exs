defmodule Autocar.Repo.Migrations.CreateProviders do
  use Ecto.Migration

  def change do
    create table(:providers) do
      add :company_name, :string
      add :address, :string
      add :brands, :string
      add :lat, :float
      add :lng, :float
      add :map_icon, :string
      add :aditional_phone, :string
      add :ranking, :float
      add :schedule, :string
      add :service, :string
      add :specialty, :string
      add :website, :string
      add :is_active, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
        
      timestamps()
    end

    create index(:providers, [:user_id])
  end
end
