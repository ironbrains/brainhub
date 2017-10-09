defmodule BrainhubWeb.RegistrationControllerTest do
  use BrainhubWeb.ConnCase

  @valid_attrs %{
    first_name: "Red",
    last_name: "Green",
    email: "rgb@email.com",
    password: "password",
    password_confirmation: "password"
  }
  @invalid_attrs %{}

  setup do
    build_conn = build_conn() |> put_req_header("accept", "application/json")
    {:ok, conn: build_conn}
  end

  describe "create/2" do
    test "creates and renders user when data is valid", %{conn: conn} do
      conn = post conn, registration_path(conn, :create), user: @valid_attrs
      assert json_response(conn, 201)["user"]
      assert json_response(conn, 201)["jwt"]
    end

    test "does not creates and renders user when data is not valid", %{conn: conn} do
      conn = post conn, registration_path(conn, :create), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
