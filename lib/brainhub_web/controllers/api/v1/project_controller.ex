defmodule BrainhubWeb.ProjectController do
  use Brainhub.Web, :controller
  import BrainhubWeb.Authentication

  plug Guardian.Plug.EnsureAuthenticated, handler: BrainhubWeb.SessionController
  plug :current_user
  plug :current_company_id
  plug :get_project when action in [:show, :edit, :update, :delete]
  plug :modifiable? when action in [:edit, :update, :delete]

  alias BrainhubWeb.{Project, Company, Team}

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn,
                                          conn.params,
                                          conn.assigns.current_user])
  end

  def index(conn, _params, _user) do
    projects = current_company(conn)
      |> assoc(:projects)
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
        |> render("show.json", project: project)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BrainhubWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, _params, _user) do
    case conn.assigns.project do
      nil ->
        conn
        |> put_status(:not_found)
        |> render(BrainhubWeb.ErrorView, "not_found.json")
      project ->
        project = project
          |> Repo.preload(teams: from(t in Team, order_by: t.id))
        render(conn, "show.json", project: project)
    end
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
        |> render(BrainhubWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, _params, _user) do
    project = conn.assigns.project

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(project)

    send_resp(conn, :no_content, "")
  end

  defp get_project(conn, _) do
    project = current_company(conn)
      |> assoc(:projects)
      |> Repo.get(conn.params["id"])
    case project do
      nil ->
        conn
        |> put_status(:not_found)
        |> render(BrainhubWeb.ErrorView, "not_found.json")
        |> halt
      project -> assign conn, :project, project
    end
  end

  def modifiable?(conn, _) do
    if Project.modifiable?(conn.assigns.project, conn.assigns.current_user) do
      conn
    else
      conn
      |> put_status(:forbidden)
      |> render(BrainhubWeb.ErrorView, "forbidden.json")
      |> halt
    end
  end

  defp current_company(conn) do
    Repo.get Company, conn.assigns.current_company_id
  end
end
