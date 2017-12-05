defmodule IntercomStatsWeb.PageController do
  use IntercomStatsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
