defmodule Brainhub.ProjectView do
  use Brainhub.Web, :view

  def render("index.json", %{projects: projects}) do
    %{projects: render_many(projects, Brainhub.ProjectView, "project.json")}
  end

  def render("show.json", %{project: project}) do
    %{id: project.id, name: project.name, description: project.description, teams: render_many(project.teams, Brainhub.TeamView, "team.json")}
  end

  def render("project.json", %{project: project}) do
    %{id: project.id, name: project.name}
  end
end
