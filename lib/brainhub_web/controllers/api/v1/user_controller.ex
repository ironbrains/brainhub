defmodule BrainhubWeb.UserController do
  use Brainhub.Web, :controller
  import BrainhubWeb.Authentication

  plug Guardian.Plug.EnsureAuthenticated, handler: BrainhubWeb.SessionController
  plug :current_user
  plug :current_company_id

  alias BrainhubWeb.User

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn,
                                          conn.params,
                                          conn.assigns.current_user])
  end

  def index(conn, _params, _user) do
    users = BrainhubWeb.Company.employees(conn.assigns.current_company_id)
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}, _user) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BrainhubWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _user) do
    if BrainhubWeb.Company.employer?(conn.assigns.current_company_id, id) do
      user = Repo.get!(User, id)
      render(conn, "show.json", user: user)
    else
      conn
      |> put_status(:forbidden)
      |> render(BrainhubWeb.ErrorView, "forbidden.json")
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}, current_user) do
    {id, _} = Integer.parse(id)
    if current_user.id == id do
      user = Repo.get!(User, id)
      changeset = User.changeset(user, user_params)

      case Repo.update(changeset) do
        {:ok, user} ->
          render(conn, "show.json", user: user)
        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(BrainhubWeb.ChangesetView, "error.json", changeset: changeset)
      end
    else
      conn
        |> put_status(:forbidden)
        |> render(BrainhubWeb.ErrorView, "forbidden.json")
    end
  end

  def delete(conn, %{"id" => id}, _user) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    send_resp(conn, :no_content, "")
  end
end
