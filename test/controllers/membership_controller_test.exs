defmodule Brainhub.MembershipControllerTest do
  use Brainhub.ConnCase

  alias Brainhub.AuthCase

  setup %{conn: conn} do
    user = insert :user
    new_member = insert :user
    company = insert :company
    project = insert :project, company: company
    team = insert :team, project: project
    membership_params = %{user_id: new_member.id}
    AuthCase.sign_in(conn, user) |> AuthCase.merge({:ok, membership_params: membership_params, team: team})
  end

  describe "create/3" do
    test "when user authendicated", %{auth_conn: conn, membership_params: membership_params, team: team} do
      conn = post conn, team_membership_path(conn, :create, team), membership: membership_params
      assert json_response(conn, 201)
    end

    test "when user didn't authendicate", %{conn: conn, membership_params: membership_params, team: team} do
      conn = post conn, team_membership_path(conn, :create, team), membership: membership_params
      assert json_response(conn, 403)["error"] == "Not Authenticated"
    end
  end
end
