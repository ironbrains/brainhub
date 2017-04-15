defmodule Brainhub.MembershipView do
  use Brainhub.Web, :view

  def render("index.json", %{memberships: memberships}) do
    %{data: render_many(memberships, Brainhub.MembershipView, "membership.json")}
  end

  def render("show.json", %{membership: membership}) do
    %{data: render_one(membership, Brainhub.MembershipView, "membership.json")}
  end

  def render("membership.json", %{membership: membership}) do
    %{id: membership.id}
  end
end
