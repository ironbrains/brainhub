defmodule BrainhubWeb.TimeEntryControllerTest do
  use BrainhubWeb.ConnCase

  alias BrainhubWeb.AuthCase

  import GoodTimes.Convert
  import GoodTimes.Date

  setup %{conn: conn} do
    user = insert :user
    company = insert :company
    project = insert :project, company: company
    team = insert :team, project: project

    {:ok, yesterday} = Calendar.DateTime.from_erl(yesterday() |> from_date, "Etc/UTC")
    today = Ecto.DateTime.utc

    insert :time_entry, start_at: yesterday, duration: 1000, user: user
    insert :time_entry, start_at: today, duration: 2000
    insert :time_entry, start_at: today, duration: 3000, user: user

    insert :employment, user: user, company: company
    AuthCase.sign_in(conn, user) |> AuthCase.merge({:ok, company: company, project: project, team: team})
  end

  describe "index/3" do
    test "when user is team member should show projects list", %{auth_conn: conn, user: user, team: team} do
      insert :team_membership, user: user, team: team
      conn = get conn, time_entry_path(conn, :index)
      assert Enum.any?(json_response(conn, 200)["projects"])
    end

    test "when user is team member should not show projects list", %{auth_conn: conn} do
      conn = get conn, time_entry_path(conn, :index)
      assert Enum.empty?(json_response(conn, 200)["projects"])
    end

    test "should show today work time", %{auth_conn: conn} do
      conn = get conn, time_entry_path(conn, :index)
      assert json_response(conn, 200)["today"] == 3000
    end
  end
end
