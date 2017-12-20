defmodule IntercomStatsWeb.ConversationsController do
  use IntercomStatsWeb, :controller

  alias IntercomStats.Repository.Conversations

  def first_response(conn, _) do
    model = Conversations.conversation_averages_by_company
    render(conn, "first_response.html", model: model)
  end

  def closing_time(conn, _) do
    model = Conversations.conversation_averages_by_company
    render(conn, "closing_time.html", model: model)
  end
end
