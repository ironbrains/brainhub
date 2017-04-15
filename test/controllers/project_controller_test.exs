defmodule Brainhub.ProjectControllerTest do
  use Brainhub.ConnCase

  alias Brainhub.Project
  alias Brainhub.AuthCase

  @valid_attrs %{name: "New Name", description: "New Description"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    user = insert :user
    company = insert :company
    insert :employment, user: user, company: company
    AuthCase.sign_in(conn, user) |> AuthCase.merge({:ok, company: company})
  end

  describe "index/3" do
    test "when user is not autherizated", %{conn: conn} do
      conn = get conn, project_path(conn, :index)
      assert json_response(conn, 403)["error"] == "Not Authenticated"
    end

    test "when user is autherizated renders only company projects", %{auth_conn: conn, company: company} do
      project_of_company = insert :project, company: company
      strange_project = insert :project
      conn = get conn, project_path(conn, :index)
      projects = json_response(conn, 200)["projects"]
      project_ids = Enum.map projects, fn p -> p["id"] end
      assert projects
      assert Enum.member?(project_ids, project_of_company.id)
      refute Enum.member?(project_ids, strange_project.id)
    end
  end

  describe "show/3" do
    test "when company's project shows chosen resource", %{auth_conn: conn, company: company} do
      project = insert :project, company: company
      conn = get conn, project_path(conn, :show, project)
      assert json_response(conn, 200)["id"] == project.id
    end

    test "when no company's project does't show chosen resource", %{auth_conn: conn} do
      project = insert :project
      conn = get conn, project_path(conn, :show, project)
      assert json_response(conn, 404)
    end

    test "renders page not found when id is nonexistent", %{auth_conn: conn} do
      conn = get conn, project_path(conn, :show, -1)
      assert json_response(conn, 404)
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
    test "renders project when user is creator of this one", %{auth_conn: conn, user: user, company: company} do
      project = insert :project, creator: user, company: company
      conn = get conn, project_path(conn, :edit, project)
      assert json_response(conn, 200)["id"] == project.id
    end

    test "does not render when user is not creator", %{auth_conn: conn, company: company} do
      project = insert :project, company: company
      conn = get conn, project_path(conn, :edit, project)
      assert json_response(conn, 403)
    end
  end

  describe "update/3" do
    test "updates when user is creator of project", %{auth_conn: conn, user: user, company: company} do
      project = insert :project, creator: user, company: company
      conn = put conn, project_path(conn, :update, project), project: @valid_attrs
      assert json_response(conn, 200)["name"] == @valid_attrs[:name]
    end

    test "rejects when user is not creator", %{auth_conn: conn, company: company} do
      project = insert :project, company: company
      conn = put conn, project_path(conn, :update, project), project: @valid_attrs
      assert json_response(conn, 403)
    end
  end

  describe "delete/3" do
    test "deletes chosen resource when user is creator", %{auth_conn: conn, user: user, company: company} do
      project = insert :project, creator: user, company: company
      conn = delete conn, project_path(conn, :delete, project)
      assert response(conn, 204)
      refute Repo.get(Project, project.id)
    end

    test "does not delete resource when user is not creator", %{auth_conn: conn, company: company} do
      project = insert :project, company: company
      conn = delete conn, project_path(conn, :delete, project)
      assert response(conn, 403)
      assert Repo.get(Project, project.id)
    end
  end
end
