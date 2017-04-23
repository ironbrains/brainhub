defmodule Brainhub.ProjectTest do
  use Brainhub.ModelCase

  alias Brainhub.Project

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  setup do
    user = insert :user
    company = insert :company
    project = insert :project, company: company
    team = insert :team, project: project
    insert :employment, user: user, company: company
    {:ok, user: user, project: project, team: team}
  end

  describe "changeset/2" do
    test "with valid attributes" do
      changeset = Project.changeset(%Project{}, @valid_attrs)
      assert changeset.valid?
    end

    test "with invalid attributes" do
      changeset = Project.changeset(%Project{}, @invalid_attrs)
      refute changeset.valid?
    end
  end

  describe "available_ids_for/1" do
    test "when user is not involved to projects", %{user: user} do
      ids = Project.available_ids_for user
      assert ids == []
    end

    test "when user is involved to projects", %{user: user, team: team, project: project} do
      insert :team_membership, user: user, team: team
      ids = Project.available_ids_for user
      assert Enum.member?(ids, project.id)
    end
  end
end
