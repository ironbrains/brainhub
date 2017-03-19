defmodule Brainhub.TeamController do
  use Brainhub.Web, :controller
  import Brainhub.Authentication

  plug Guardian.Plug.EnsureAuthenticated, handler: Brainhub.SessionController
  plug :current_user

  alias Brainhub.Team

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn,
                                          conn.params,
                                          conn.assigns.current_user])
  end

  def index(conn, _params, _user) do
    teams = Repo.all(Team)
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"team" => team_params}, user) do
    changeset = Team.changeset(%Team{}, Map.put(team_params, "user_id", user.id))

    case Repo.insert(changeset) do
      {:ok, team} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", team_path(conn, :show, team))
        |> render("show.json", team: team)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Brainhub.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _user) do
    team = Repo.get!(Team, id)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}, _user) do
    team = Repo.get!(Team, id)
    changeset = Team.changeset(team, team_params)

    case Repo.update(changeset) do
      {:ok, team} ->
        render(conn, "show.json", team: team)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Brainhub.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, _user) do
    team = Repo.get!(Team, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(team)

    send_resp(conn, :no_content, "")
  end
end
