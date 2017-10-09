defmodule BrainhubWeb.UserControllerTest do
  use BrainhubWeb.ConnCase

  alias BrainhubWeb.AuthCase

  setup %{conn: conn} do
    user = insert :user
    company = insert :company
    _employment = insert :employment, user: user, company: company
    AuthCase.sign_in(conn, user) |> AuthCase.merge({:ok, company: company})
  end

  describe "index/3" do
    test "includes only company employees", %{auth_conn: conn, user: user, company: company} do
      employee = insert :user
      other_user = insert :user
      _employment = insert :employment, user: employee, company: company

      conn = get conn, user_path(conn, :index)
      response = json_response(conn, 200)["users"]
      user_ids = Enum.map(response, fn u -> u["id"] end)

      assert response
      assert Enum.member?(user_ids, user.id)
      assert Enum.member?(user_ids, employee.id)
      refute Enum.member?(user_ids, other_user.id)
    end
  end

  describe "show/3" do
    test "shows own data", %{auth_conn: conn, user: user} do
      conn = get conn, user_path(conn, :show, user)
      response = json_response(conn, 200)
      assert response
      assert response["id"] == user.id
      assert response["first_name"] == user.first_name
    end

    test "shows data of colleague", %{auth_conn: conn, company: company} do
      colleague = insert :user
      _employment = insert :employment, user: colleague, company: company
      conn = get conn, user_path(conn, :show, colleague)
      response = json_response(conn, 200)
      assert response
      assert response["id"] == colleague.id
      assert response["first_name"] == colleague.first_name
    end

    test "does not show data of employee of other company", %{auth_conn: conn} do
      user = insert :user
      _employment = insert :employment, user: user
      conn = get conn, user_path(conn, :show, user)
      assert json_response(conn, 403)
    end
  end

  describe "create/3" do
  end

  describe "update/3" do
    test "changes own data", %{auth_conn: conn, user: user} do
      attrs = %{first_name: "Super New First name"}
      conn = put conn, user_path(conn, :update, user), user: attrs
      response = json_response(conn, 200)
      assert response
      assert response["id"] == user.id
      assert response["first_name"] == attrs[:first_name]
      assert response["first_name"] != user.first_name
    end

    test "does not changes someone else data", %{auth_conn: conn} do
      attrs = %{first_name: "Super New First name"}
      user = insert :user
      conn = put conn, user_path(conn, :update, user), user: attrs
      assert json_response(conn, 403)
    end
  end

  describe "delete/3" do
  end
end
