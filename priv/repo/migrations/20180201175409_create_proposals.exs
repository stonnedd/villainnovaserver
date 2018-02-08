defmodule Autocar.Repo.Migrations.CreateProposals do
  use Ecto.Migration

  def change do
    create table(:proposals) do
      add :price, :integer
      add :time, :string
      add :comment, :text
      add :c_status, :integer ,default: 0
      add :p_status, :integer ,default: 0
      add :request_id, references(:requests, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:proposals, [:request_id])
  end
end
