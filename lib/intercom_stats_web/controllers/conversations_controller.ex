defmodule IntercomStatsWeb.ConversationsController do
  use IntercomStatsWeb, :controller

  def first_response(conn, _) do
    
    render(conn, "first_response.html")
  end

  def closing_time(conn, _) do
    render(conn, "closing_time.html")
  end
end
