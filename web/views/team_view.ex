defmodule Brainhub.TeamView do
  use Brainhub.Web, :view

  def render("index.json", %{teams: teams}) do
    %{teams: render_many(teams, Brainhub.TeamView, "team.json")}
  end

  def render("show.json", %{team: team}) do
    %{id: team.id, name: team.name, project_id: team.project_id}
  end

  def render("team.json", %{team: team}) do
    %{id: team.id}
  end
end
