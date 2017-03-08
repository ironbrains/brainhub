defmodule Brainhub.ProjectController do
  use Brainhub.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: Brainhub.SessionController

  alias Brainhub.Project

  def index(conn, _params) do
    projects = current_user(conn)
      |> assoc(:created_projects)
      |> Repo.all
    render(conn, "index.json", projects: projects)
  end

  def create(conn, %{"project" => project_params}) do
    changeset = current_user(conn)
      |> build_assoc(:created_projects)
      |> Project.changeset(project_params)

    case Repo.insert(changeset) do
      {:ok, project} ->
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

  def show(conn, %{"id" => id}) do
    project = Repo.get!(Project, id)
      |> Repo.preload(:teams)
    render(conn, "show.json", project: project)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Repo.get!(Project, id)
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

  def delete(conn, %{"id" => id}) do
    project = Repo.get!(Project, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(project)

    send_resp(conn, :no_content, "")
  end

  defp current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
