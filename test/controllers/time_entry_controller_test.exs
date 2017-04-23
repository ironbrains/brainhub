defmodule Brainhub.TimeEntryControllerTest do
#  use Brainhub.ConnCase
#
#  alias Brainhub.AuthCase
#
#  setup %{conn: conn} do
#    user = insert :user
#    company = insert :company
#    project = insert :project, company: company
#    team = insert :team, project: project
#
#    insert :employment, user: user, company: company
#    insert :team_membership, user: user, team: team
#    AuthCase.sign_in(conn, user) |> AuthCase.merge({:ok, company: company, project: project})
#  end
#
#  describe "index/3" do
#    test "should show projects list", %{auth_conn: conn} do
#      conn = get conn, time_entry_path(conn, :index)
#      assert json_response(conn, 200)["projects"] != %{}
#    end
#  end
end
