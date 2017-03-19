defmodule Brainhub.Repo.Migrations.AddCompanyIdToProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :company_id, references(:companies, on_delete: :delete_all)
    end
  end
end
