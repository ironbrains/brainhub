defmodule BrainhubWeb.UserView do
  use Brainhub.Web, :view

  def render("index.json", %{users: users}) do
    %{users: render_many(users, BrainhubWeb.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{
      id: user.id,
      avatar: gravatar(user),
      avatar_thumb: gravatar(user, :thumb),
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      employment: render_one(user, BrainhubWeb.UserView, "employment.json")
    }
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      avatar_thumb: gravatar(user, :thumb),
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name
    }
  end

  def render("employment.json", %{user: user}) do
    render_one(BrainhubWeb.User.current_employment(user), BrainhubWeb.EmploymentView, "employment.json")
  end

  defp gravatar(user), do: gravatar user, %{size: 300}

  defp gravatar(user, :thumb), do: gravatar user, %{size: 128}

  defp gravatar(%{email: email}, %{size: size}) do
    domain = "gravatar.com/avatar/"
    hash = :crypto.hash(:md5, email) |> Base.encode16(case: :lower)
    %URI{scheme: "https", host: domain, path: hash, query: URI.encode_query([s: size])}
      |> to_string
  end
end
