defmodule Brainhub.TimeEntryTest do
  use Brainhub.ModelCase

  alias Brainhub.TimeEntry

  @valid_attrs %{project_id: 1, user_id: 1, duration: 100, start_at: Calendar.DateTime.now_utc}
  @invalid_attrs %{}

  setup do
    user = insert :user
    company = insert :company
    project = insert :project, company: company
    insert :employment, user: user, company: company
    {:ok, user: user, project: project}
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
end
