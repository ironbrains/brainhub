defmodule Brainhub.Repo.Migrations.CreateTeamMembership do
  use Ecto.Migration

  def change do
    create table(:team_memberships) do
      add :user_id, references(:users, on_delete: :nothing)
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end
    create index(:team_memberships, [:user_id])
    create index(:team_memberships, [:team_id])
    create index(:team_memberships, [:user_id, :team_id])

  end
end
