defmodule Brainhub.Repo.Migrations.CreateTimeEntry do
  use Ecto.Migration

  def change do
    create table(:time_entries) do
      add :project_id, references(:projects, on_delete: :delete_all)
      add :user_id,    references(:users,    on_delete: :delete_all)

      add :start_at,   :utc_datetime, null: false, default: fragment("now()")
      add :duration,   :integer,      null: false

      timestamps()
    end

  end
end
