defmodule IntercomStatsWeb.PageController do
  use IntercomStatsWeb, :controller

  alias IntercomStats.Intercom.Tags
  alias IntercomStats.Intercom.Conversations

  def index(conn, _params) do
    # Get conversations from DB
    render conn, "index.html"
  end

  def get_from_api(conn, _params) do
    Tags.save_from_api
    Conversations.save_from_api
    
    render conn, "index.html"
  end
end
