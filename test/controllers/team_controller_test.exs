defmodule BrainhubWeb.TeamControllerTest do
  use BrainhubWeb.ConnCase

  alias BrainhubWeb.Team
  alias BrainhubWeb.AuthCase

  @valid_attrs %{name: "Team name", project_id: nil}

  setup %{conn: conn} do
    user = insert :user
    company = insert :company
    project = insert :project, company: company
    attrs = %{@valid_attrs | project_id: project.id}
    AuthCase.sign_in(conn, user) |> AuthCase.merge({:ok, company: company, valid_attrs: attrs})
  end

  describe "create/3" do
    test "creates team when user is logged in", %{auth_conn: conn, user: user, company: company, valid_attrs: valid_attrs} do
      insert :employment, user: user, company: company, role: "CEO"
      conn = post conn, team_path(conn, :create), team: valid_attrs
      assert json_response(conn, 201)["id"]
      team = Repo.get(Team, json_response(conn, 201)["id"])
      assert team.project_id == valid_attrs[:project_id]
    end

    test "does not create team when user is not logged in", %{conn: conn, user: user, company: company, valid_attrs: valid_attrs} do
      insert :employment, user: user, company: company, role: "CEO"
      conn = post conn, team_path(conn, :create), team: valid_attrs
      assert json_response(conn, 403)["errors"] != %{}
    end

    test "does not create team when user is not company employee", %{auth_conn: conn, valid_attrs: valid_attrs} do
      conn = post conn, team_path(conn, :create), team: valid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "does not create team when user is not in management", %{auth_conn: conn, user: user, company: company, valid_attrs: valid_attrs} do
      insert :employment, user: user, company: company, role: "developer"
      conn = post conn, team_path(conn, :create), team: valid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
