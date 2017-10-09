defmodule BrainhubWeb.TeamMembershipTest do
  use BrainhubWeb.ModelCase

  import BrainhubWeb.Factory

  alias BrainhubWeb.TeamMembership

  @invalid_attrs %{}

  setup do
    user = insert :user
    initiator = insert :user
    team = insert(:team) |> Brainhub.Repo.preload(:company)

    {:ok, user: user, initiator: initiator, team: team, company: team.company}
  end

  describe "changeset/2" do
    test "with valid attributes", %{user: user, initiator: initiator, team: team, company: company} do
      insert :employment, user: user, company: company
      insert :employment, user: initiator, company: company
      changeset = TeamMembership.changeset(%TeamMembership{}, %{user_id: user.id, team_id: team.id, initiator_id: initiator.id})
      assert changeset.valid?
    end

    test "with invalid attributes" do
      changeset = TeamMembership.changeset(%TeamMembership{}, @invalid_attrs)
      refute changeset.valid?
    end

    test "when initiator is not an employee", %{user: user, initiator: initiator, team: team, company: company} do
      insert :employment, user: user, company: company
      changeset = TeamMembership.changeset(%TeamMembership{}, %{user_id: user.id, team_id: team.id, initiator_id: initiator.id})
      refute changeset.valid?
    end

    test "when initiator is not in management", %{user: user, initiator: initiator, team: team, company: company} do
      insert :employment, user: user, company: company
      insert :employment, user: initiator, company: company, role: "developer"
      changeset = TeamMembership.changeset(%TeamMembership{}, %{user_id: user.id, team_id: team.id, initiator_id: initiator.id})
      refute changeset.valid?
    end

    test "when user is not an employee", %{user: user, initiator: initiator, team: team, company: company} do
      insert :employment, user: initiator, company: company
      changeset = TeamMembership.changeset(%TeamMembership{}, %{user_id: user.id, team_id: team.id, initiator_id: initiator.id})
      refute changeset.valid?
    end
  end
end
