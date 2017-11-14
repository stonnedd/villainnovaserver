defmodule Autocar.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :name, :string
      add :email, :string
      add :phone, :integer
      add :password, :string

      timestamps()
    end

    create unique_index(:customers, [:email])
  end
end
