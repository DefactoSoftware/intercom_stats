defmodule IntercomStatsWeb.PageController do
  use IntercomStatsWeb, :controller

  def index(conn, _params) do
    # Get conversations from DB
    render conn, "index.html"
  end

  def get_from_api(conn, _params) do
    # Get tags, users and conversations from the intercom API
    # Put in DB
    render conn, "index.html"
  end
end
