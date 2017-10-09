defmodule BrainhubWeb.PageControllerTest do
  use BrainhubWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Brainhub"
  end
end
