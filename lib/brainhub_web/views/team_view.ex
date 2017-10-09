defmodule BrainhubWeb.TeamView do
  use Brainhub.Web, :view

  def render("index.json", %{teams: teams}) do
    %{teams: render_many(teams, BrainhubWeb.TeamView, "team.json")}
  end

  def render("show.json", %{team: team}) do
    team = Brainhub.Repo.preload team, :members
    %{
      id: team.id,
      name: team.name,
      project_id: team.project_id,
      members: render_many(team.members, BrainhubWeb.UserView, "user.json")
    }
  end

  def render("team.json", %{team: team}) do
    %{id: team.id, name: team.name}
  end
end
