defmodule BrainhubWeb.TimeEntryController do
  use Brainhub.Web, :controller
  require Ecto.Date

  alias BrainhubWeb.TimeEntry
  import BrainhubWeb.Authentication

  plug Guardian.Plug.EnsureAuthenticated, handler: BrainhubWeb.SessionController
  plug :current_user

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn,
                                          conn.params,
                                          conn.assigns.current_user])
  end

  def index(conn, _params, user) do
    projects = BrainhubWeb.Project.available_for(user)
    today = BrainhubWeb.TimeEntry.duration_for user, Ecto.DateTime.utc
    render(conn, "index.json", projects: projects, today: today)
  end

  def create(conn, %{"time_entry" => time_entry_params}, _user) do
    changeset = TimeEntry.changeset(%TimeEntry{}, time_entry_params)

    case Repo.insert(changeset) do
      {:ok, time_entry} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", time_entry_path(conn, :show, time_entry))
        |> render("show.json", time_entry: time_entry)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BrainhubWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _user) do
    time_entry = Repo.get!(TimeEntry, id)
    render(conn, "show.json", time_entry: time_entry)
  end

  def update(conn, %{"id" => id, "time_entry" => time_entry_params}, _user) do
    time_entry = Repo.get!(TimeEntry, id)
    changeset = TimeEntry.changeset(time_entry, time_entry_params)

    case Repo.update(changeset) do
      {:ok, time_entry} ->
        render(conn, "show.json", time_entry: time_entry)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BrainhubWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, _user) do
    time_entry = Repo.get!(TimeEntry, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(time_entry)

    send_resp(conn, :no_content, "")
  end
end
