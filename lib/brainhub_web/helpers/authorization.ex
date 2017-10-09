defmodule BrainhubWeb.Authentication do
  import Plug.Conn

  def current_user(conn, _) do
    assign conn, :current_user, Guardian.Plug.current_resource(conn)
  end

  def current_company_id(conn, _) do
    employment = BrainhubWeb.User.current_employment conn.assigns.current_user
    assign conn, :current_company_id, employment.company_id
  end
end
