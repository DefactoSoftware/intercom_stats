defmodule IntercomStatsWeb.PageController do
  use IntercomStatsWeb, :controller
  use Timex

  alias IntercomStats.Intercom
  alias IntercomStats.Repository

  def index(conn, _params) do
    conn
    |> assign(:model, model())
    |> render("index.html")
  end

  def get_from_api(conn, _params) do
    Intercom.Tags.save_from_api
    Intercom.Conversations.save_from_api

    conn
    |> assign(:model, model())
    |> render("index.html")
  end

  defp model() do
    conversations = Repository.Conversations.list_all_conversations(%{})

    %{
      average_response_time:
        Repository.Conversations.average_first_response(conversations),
      average_closing_time:
        Repository.Conversations.average_closing_time(conversations)
    }
  end
end
