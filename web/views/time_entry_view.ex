defmodule Brainhub.TimeEntryView do
  use Brainhub.Web, :view

  def render("index.json", %{projects: projects, today: today}) do
    %{projects: render_many(projects, Brainhub.ProjectView, "project.json"), today: today}
  end

  def render("show.json", %{time_entry: time_entry}) do
    %{data: render_one(time_entry, Brainhub.TimeEntryView, "time_entry.json")}
  end

  def render("time_entry.json", %{time_entry: time_entry}) do
    %{id: time_entry.id}
  end
end
