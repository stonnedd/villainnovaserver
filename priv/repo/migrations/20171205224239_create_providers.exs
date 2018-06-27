defmodule Autocar.Repo.Migrations.CreateProviders do
  use Ecto.Migration

  def change do
    create table(:providers) do
      add :company_name, :string
      add :company_email, :string
      add :address, :string
      add :brands, :string
      add :lat, :float
      add :lng, :float
      add :map_icon, :string
      add :aditional_phone, :string
      add :ranking, :float, default: 0.0
      add :ranking_count, :integer, default: 1
      add :ranking_values, {:array, :integer}	
      add :schedule, :string
      add :service, :string
      add :specialty, :string
      add :website, :string
      add :is_active, :integer, default: 0, null: false
      add :status, :integer, default: 0
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :point, :geography
        
      timestamps()
    end

    create index(:providers, [:user_id])
    create index(:providers, [:point])
  end
end
