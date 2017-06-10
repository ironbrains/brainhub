defmodule Brainhub.Repo.Migrations.AddStartAtAndEndAtToEmployments do
  use Ecto.Migration

  def change do
    alter table(:employments) do
      add :start_at, :utc_datetime, null: false, default: fragment("now()")
      add :end_at,   :utc_datetime
    end
  end
end
