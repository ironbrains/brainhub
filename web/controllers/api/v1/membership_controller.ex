defmodule Brainhub.MembershipController do
  use Brainhub.Web, :controller
  import Brainhub.Authentication

  plug Guardian.Plug.EnsureAuthenticated, handler: Brainhub.SessionController
  plug :current_user

  alias Brainhub.TeamMembership

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn,
                                          conn.params,
                                          conn.assigns.current_user])
  end

  def create(conn, %{"team_id" => team_id, "membership" => membership_params}, user) do
    membership_params = membership_params
      |> Map.put("initiator_id", user.id)
      |> Map.put("team_id", team_id)
    changeset = TeamMembership.changeset(%TeamMembership{}, membership_params)

    case Repo.insert(changeset) do
      {:ok, membership} ->
        conn
        |> put_status(:created)
        |> render("show.json", membership: membership)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Brainhub.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, _user) do
    membership = Repo.get!(TeamMembership, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(membership)

    send_resp(conn, :no_content, "")
  end
end
