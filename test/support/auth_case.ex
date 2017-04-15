defmodule Brainhub.AuthCase do
  use Phoenix.ConnTest

  def sign_in(conn, user) do
    conn = put_req_header(conn, "accept", "application/json")
    {:ok, jwt, _} = Guardian.encode_and_sign(user)
    {:ok, conn: conn, auth_conn: put_req_header(conn, "authorization", jwt), user: user}
  end

  def merge({:ok, first}, {:ok, second}) do
    {:ok, Keyword.merge(first, second)}
  end
end