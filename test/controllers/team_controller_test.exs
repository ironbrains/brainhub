defmodule Brainhub.TeamControllerTest do
  use Brainhub.ConnCase

  import Brainhub.Factory

  alias Brainhub.Team

  @valid_attrs %{name: "Team name", project_id: nil}

  setup %{conn: conn} do
    user = insert :user
    company = insert :company
    _employment = insert :employment, user: user, company: company
    conn = put_req_header(conn, "accept", "application/json")
    {:ok, jwt, _} = Guardian.encode_and_sign(user)
    {:ok, conn: conn, auth_conn: put_req_header(conn, "authorization", jwt), user: user, company: company}
  end

  describe "create/3" do
    test "creates team when user is logged in", %{auth_conn: conn, user: user, company: company} do
      project = insert :project, creator: user, company: company
      conn = post conn, team_path(conn, :create), team: %{@valid_attrs | project_id: project.id}
      assert json_response(conn, 201)["id"]
      team = Repo.get(Team, json_response(conn, 201)["id"])
      assert team.project_id == project.id
    end

    test "does not create team when user is not logged in", %{conn: conn} do
      project = insert :project
      conn = post conn, team_path(conn, :create), team: %{@valid_attrs | project_id: project.id}
      assert json_response(conn, 403)["errors"] != %{}
    end

    test "does not create team when user is not company employee", %{auth_conn: conn} do
      project = insert :project
      conn = post conn, team_path(conn, :create), team: %{@valid_attrs | project_id: project.id}
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
