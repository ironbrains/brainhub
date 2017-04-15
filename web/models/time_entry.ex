defmodule Brainhub.TimeEntry do
  use Brainhub.Web, :model

  schema "time_entries" do
    field :start_at, :utc_datetime
    field :duration, :integer

    belongs_to :project, Brainhub.Project
    belongs_to :user, Brainhub.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:start_at, :duration, :project_id, :user_id])
    |> validate_required([:start_at, :duration])
    |> assoc_constraint(:project)
    |> assoc_constraint(:user)
  end
end
