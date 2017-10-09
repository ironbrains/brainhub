defmodule BrainhubWeb.PageController do
  use Brainhub.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
