defmodule Brainhub.Authentication do
  import Plug.Conn

  def current_user(conn, _) do
    assign conn, :current_user, Guardian.Plug.current_resource(conn)
  end
end