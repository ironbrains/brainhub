defmodule Brainhub.TimeEntry do
  use Brainhub.Web, :model

  alias Ecto.{Time, DateTime}

  schema "time_entries" do
    field :start_at, Ecto.DateTime
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

  def duration_for_date(query, %Ecto.DateTime{year: year, month: month, day: day}) do
    duration_for_date query, %Ecto.Date{year: year, month: month, day: day}
  end

  def duration_for_date(query, nil) do
    Brainhub.Repo.aggregate(query, :sum, :duration)
  end

  def duration_for_date(query, date) do
    start_of_day = DateTime.from_date_and_time date, Time.from_erl({0, 0, 0})
    end_of_day = DateTime.from_date_and_time date, Time.from_erl({23, 59, 59})
    query
    |> where([e], e.start_at >= ^start_of_day and e.start_at <= ^end_of_day)
    |> Brainhub.Repo.aggregate(:sum, :duration)
  end

  def created_by(%Brainhub.User{id: user_id}), do: created_by user_id

  def created_by(user_id) do
    Brainhub.TimeEntry
    |> where([t], t.user_id == ^user_id)
    |> Brainhub.Repo.all
  end

  def duration_for(user), do: duration_for user, nil

  def duration_for(%Brainhub.User{id: user_id}, date), do: duration_for user_id, date

  def duration_for(user_id, date) do
    Brainhub.TimeEntry
    |> where([t], t.user_id == ^user_id)
    |> Brainhub.TimeEntry.duration_for_date(date)
  end
end
