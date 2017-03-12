defmodule Brainhub.ProjectControllerTest do
  use Brainhub.ConnCase

  import Brainhub.Factory

  alias Brainhub.Project

  @valid_attrs %{name: "New Name", description: "New Description"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    user = insert(:user)
    conn = put_req_header(conn, "accept", "application/json")
    {:ok, jwt, _} = Guardian.encode_and_sign(user)
    {:ok, conn: conn, auth_conn: put_req_header(conn, "authorization", jwt), user: user}
  end

  describe "index/3" do
    test "when user is autherizated", %{auth_conn: conn} do
      conn = get conn, project_path(conn, :index)
      assert json_response(conn, 200)["projects"] == []
    end

    test "when user is not autherizated", %{conn: conn} do
      conn = get conn, project_path(conn, :index)
      assert json_response(conn, 403)["error"] == "Not Authenticated"
    end
   end

  describe "show/3" do
    test "shows chosen resource", %{auth_conn: conn} do
      project = insert :project
      conn = get conn, project_path(conn, :show, project)
      assert json_response(conn, 200)["id"] == project.id
    end

    test "renders page not found when id is nonexistent", %{auth_conn: conn} do
      assert_error_sent 404, fn ->
        get conn, project_path(conn, :show, -1)
      end
    end
  end

  describe "create/3" do
    test "creates and renders resource when data is valid", %{auth_conn: conn, user: user} do
      conn = post conn, project_path(conn, :create), project: @valid_attrs
      assert json_response(conn, 201)["id"]
      project = Repo.get(Project, json_response(conn, 201)["id"]) |> Repo.preload(:creator)
      assert project.creator == user
    end

    test "does not create resource and renders errors when data is invalid", %{auth_conn: conn} do
      conn = post conn, project_path(conn, :create), project: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "edit/3" do
    test "renders project when user is creator of this one", %{auth_conn: conn, user: user} do
      project = insert :project, creator: user
      conn = get conn, project_path(conn, :edit, project)
      assert json_response(conn, 200)["id"] == project.id
    end

    test "does not render when user is not creator", %{auth_conn: conn} do
      project = insert :project
      conn = get conn, project_path(conn, :edit, project)
      assert json_response(conn, 403)
    end
  end

  describe "update/3" do
    test "updates when user is creator of project", %{auth_conn: conn, user: user} do
      project = insert :project, creator: user
      conn = put conn, project_path(conn, :update, project), project: @valid_attrs
      assert json_response(conn, 200)["name"] == @valid_attrs[:name]
    end

    test "rejects when user is not creator", %{auth_conn: conn} do
      project = insert :project
      conn = put conn, project_path(conn, :update, project), project: @valid_attrs
      assert json_response(conn, 403)
    end
  end

  describe "delete/3" do
    test "deletes chosen resource when user is creator", %{auth_conn: conn, user: user} do
      project = insert :project, creator: user
      conn = delete conn, project_path(conn, :delete, project)
      assert response(conn, 204)
      refute Repo.get(Project, project.id)
    end

    test "does not delete resource when user is not creator", %{auth_conn: conn} do
      project = insert :project
      conn = delete conn, project_path(conn, :delete, project)
      assert response(conn, 403)
      assert Repo.get(Project, project.id)
    end
  end
end
