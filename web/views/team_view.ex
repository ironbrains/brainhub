defmodule Brainhub.TeamView do
  use Brainhub.Web, :view

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, Brainhub.TeamView, "team.json")}
  end

  def render("show.json", %{team: team}) do
    %{data: render_one(team, Brainhub.TeamView, "team.json")}
  end

  def render("team.json", %{team: team}) do
    %{id: team.id}
  end
end
