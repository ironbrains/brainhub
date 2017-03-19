defmodule Brainhub.Repo.Migrations.CreateEmployment do
  use Ecto.Migration

  def change do
    create table(:employments) do
      add :role,       :string, null: false, default: "admin"
      add :user_id,    references(:users, on_delete: :delete_all)
      add :company_id, references(:companies, on_delete: :delete_all)

      timestamps()
    end
    create index(:employments, [:user_id])
    create index(:employments, [:company_id])
    create index(:employments, [:user_id, :company_id])

  end
end
