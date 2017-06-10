defmodule Brainhub.TimeEntryTest do
  use Brainhub.ModelCase

  alias Brainhub.TimeEntry

  import GoodTimes.Convert
  import GoodTimes.Date

  @valid_attrs %{project_id: 1, user_id: 1, duration: 100, start_at: Ecto.DateTime.utc}
  @invalid_attrs %{}

  setup do
    user = insert :user
    company = insert :company
    project = insert :project, company: company
    {:ok, yesterday} = Calendar.DateTime.from_erl(yesterday() |> from_date, "Etc/UTC")
    today = Ecto.DateTime.utc

    insert :time_entry, start_at: yesterday, duration: 3000, user: user
    insert :time_entry, start_at: today, duration: 1000
    insert :time_entry, start_at: today, duration: 2000, user: user

    insert :employment, user: user, company: company
    {:ok, user: user, project: project, yesterday: yesterday, today: today}
  end

  describe "changeset" do
    test "with valid attributes", %{user: user, project: project} do
      %{@valid_attrs | user_id: user.id, project_id: project.id}
      changeset = TimeEntry.changeset(%TimeEntry{}, @valid_attrs)
      assert changeset.valid?
    end

    test "with invalid attributes" do
      changeset = TimeEntry.changeset(%TimeEntry{}, @invalid_attrs)
      refute changeset.valid?
    end
  end

  describe "duration_for_date/2" do
    test "with Ecto.DateTime as param" , %{today: today} do
      assert TimeEntry.duration_for_date(TimeEntry, today) == 3000
    end
  end

  describe "created_by/1" do
    test "with Brainhub.User as param", %{user: user} do
      entries = TimeEntry.created_by user
      assert length(entries) == 2
    end

    test "with id (interger) as param", %{user: user} do
      entries = TimeEntry.created_by user.id
      assert length(entries) == 2
    end
  end

  describe "duration_for/2" do
    test "returns duration of user entries by date", %{user: user, today: today} do
      duration = TimeEntry.duration_for(user, today)
      assert duration == 2000
    end

    test "returns duration of user entries when date is nil", %{user: user} do
      duration = TimeEntry.duration_for(user, nil)
      assert duration == 5000
    end
  end
end
