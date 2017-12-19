defmodule IntercomStatsWeb.ConversationsController do
  use IntercomStatsWeb, :controller

  alias IntercomStats.Repository.Conversations

  def first_response(conn, _) do
    model = Conversations.conversation_first_response_by_company
    render(conn, "first_response.html", model: model)
  end

  def closing_time(conn, _) do
    render(conn, "closing_time.html")
  end
end
