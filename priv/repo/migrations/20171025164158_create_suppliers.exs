defmodule Autocar.Repo.Migrations.CreateSuppliers do
  use Ecto.Migration

  def change do
    create table(:suppliers) do
      add :email, :string
      add :service, :string
      add :specialty, :string
      add :brands, :string
      add :address, :string
      add :lat, :float
      add :lng, :float
      add :schedule, :string
      add :website, :string
      add :map_icon, :string
      add :manager, :string
      add :phone_manager, :string
      add :ranking, :integer
      add :is_active, :boolean
      timestamps()
    end

    create unique_index(:suppliers, [:email])
  end
end
