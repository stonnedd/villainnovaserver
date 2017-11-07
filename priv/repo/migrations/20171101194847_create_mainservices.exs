defmodule Autocar.Repo.Migrations.CreateMainservices do
  use Ecto.Migration

  def change do
    create table(:mainservices) do
      add :name, :string

      timestamps()
    end

  end
end
