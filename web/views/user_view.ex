defmodule Brainhub.UserView do
  use Brainhub.Web, :view

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, Brainhub.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      employment: render_one(user, Brainhub.UserView, "employment.json")
    }
  end

  def render("user.json", %{user: user}) do
    %{id: user.id}
  end

  def render("employment.json", %{user: user}) do
    render_one(Brainhub.User.current_employment(user), Brainhub.EmploymentView, "employment.json")
  end
end
