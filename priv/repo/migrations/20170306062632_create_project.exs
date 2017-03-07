defmodule Brainhub.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string, null: false
      add :description, :text
      add :creator_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
    create index(:projects, [:creator_id])

  end
end
