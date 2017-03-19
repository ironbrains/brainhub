defmodule Brainhub.TeamTest do
  use Brainhub.ModelCase

  alias Brainhub.Team

  import Brainhub.Factory

  @valid_attrs %{name: "Team Name", project_id: nil, user_id: nil}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    employment = insert(:employment)
      |> Repo.preload(:user)
      |> Repo.preload(:company)
    project = insert :project, creator: employment.user, company: employment.company
    changeset = Team.changeset(%Team{}, %{@valid_attrs | user_id: employment.user_id, project_id: project.id})
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Team.changeset(%Team{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset when user is not employee" do
    user = insert :user
    employment = insert(:employment) |> Repo.preload(:company)
    project = insert :project, company: employment.company
    changeset = Team.changeset(%Team{}, %{@valid_attrs | user_id: user.id, project_id: project.id})
    refute changeset.valid?
  end
end
