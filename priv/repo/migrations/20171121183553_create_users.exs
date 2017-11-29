defmodule Autocar.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :password, :string
      add :phone, :string
      add :profile, :string
      add :token, :string, size: 512

      timestamps()
    end
    create unique_index(:users, [:email])
  end
end
