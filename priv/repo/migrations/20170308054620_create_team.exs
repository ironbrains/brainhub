defmodule Brainhub.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string, null: false
      add :project_id, references(:projects, on_delete: :delete_all)

      timestamps()
    end
    create index(:teams, [:project_id])

  end
end
