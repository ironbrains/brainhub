defmodule Brainhub.MembershipView do
  use Brainhub.Web, :view

  def render("index.json", %{memberships: memberships}) do
    %{data: render_many(memberships, Brainhub.MembershipView, "membership.json")}
  end

  def render("show.json", %{membership: membership}) do
    render_one(membership, Brainhub.MembershipView, "membership.json")
  end

  def render("membership.json", %{membership: membership}) do
    membership = Brainhub.Repo.preload membership, :user
    %{
      id: membership.id,
      user: render_one(membership.user, Brainhub.UserView, "user.json"),
      team_id: membership.team_id
    }
  end
end
