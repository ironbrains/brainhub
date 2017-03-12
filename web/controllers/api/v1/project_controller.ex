defmodule Brainhub.ProjectController do
  use Brainhub.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: Brainhub.SessionController
  plug :current_user
  plug :verify_creator when action in [:edit, :update, :delete]

  alias Brainhub.Project

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn,
                                          conn.params,
                                          conn.assigns.current_user])
  end



  def index(conn, _params, user) do
    projects = user
      |> assoc(:created_projects)
      |> Repo.all
    render(conn, "index.json", projects: projects)
  end

  def create(conn, %{"project" => project_params}, user) do
    changeset = user
      |> build_assoc(:created_projects)
      |> Project.changeset(project_params)

    case Repo.insert(changeset) do
      {:ok, project} ->
        project = Repo.preload(project, :teams)
        conn
        |> put_status(:created)
        |> put_resp_header("location", project_path(conn, :show, project))
        |> render("show.json", project: project)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Brainhub.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _user) do
    project = Repo.get!(Project, id)
      |> Repo.preload(:teams)
    render(conn, "show.json", project: project)
  end

  def edit(conn, _params, _user) do
    project = conn.assigns.project |> Repo.preload(:teams)
    render(conn, "show.json", project: project)
  end

  def update(conn, %{"project" => project_params}, _user) do
    project = conn.assigns.project
    changeset = Project.changeset(project, project_params)

    case Repo.update(changeset) do
      {:ok, project} ->
        render conn, "show.json", project: Repo.preload(project, :teams)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Brainhub.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, _params, _user) do
    project = conn.assigns.project

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(project)

    send_resp(conn, :no_content, "")
  end

  defp current_user(conn, _) do
    assign conn, :current_user, Guardian.Plug.current_resource(conn)
  end

  defp verify_creator(conn, _) do
    project = conn.assigns.current_user
      |> assoc(:created_projects)
      |> Repo.get(conn.params["id"])
    case project do
      nil ->
        conn
        |> put_status(:forbidden)
        |> render(Brainhub.ErrorView, "forbidden.json")
        |> halt
      _project ->
        assign(conn, :project, project)
    end
  end
end
