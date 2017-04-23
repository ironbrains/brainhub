defmodule Brainhub.TimeEntryView do
  use Brainhub.Web, :view

  def render("index.json", %{projects: projects, time_entries: time_entries}) do
    %{time_entries: render_many(time_entries, Brainhub.TimeEntryView, "time_entries.json")}
  end

  def render("show.json", %{time_entry: time_entry}) do
    %{data: render_one(time_entry, Brainhub.TimeEntryView, "time_entry.json")}
  end

  def render("time_entry.json", %{time_entry: time_entry}) do
    %{id: time_entry.id}
  end
end
