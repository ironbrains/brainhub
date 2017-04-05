defmodule Brainhub.Repo.Migrations.AddStartAtAndEndAtToEmployments do
  use Ecto.Migration

  def change do
    alter table(:employments) do
      add :start_at, :datetime, null: false, default: fragment("now()")
      add :end_at,   :datetime
    end
  end
end
