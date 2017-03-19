defmodule Brainhub.Repo.Migrations.CreateCompany do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name,     :string, null: false
      add :web_site, :string

      timestamps()
    end

  end
end
