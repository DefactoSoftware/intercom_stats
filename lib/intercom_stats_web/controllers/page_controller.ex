defmodule IntercomStatsWeb.PageController do
  use IntercomStatsWeb, :controller
  use Timex

  alias IntercomStats.Intercom.{Conversations, Tags}
  alias IntercomStats.Repository

  def index(conn, _params) do
    conn
    |> assign(:model, model())
    |> render("index.html")
  end

  def get_from_api(conn, _params) do
    Tags.save_from_api
    Task.start(fn -> Conversations.save_from_api end)

    conn
    |> assign(:model, model())
    |> render("index.html")
  end

  def search(conn,
      %{"search" => %{"from_date" => from_date, "to_date" => to_date}}) do
    conn
    |> assign(:model, model(from_date, to_date))
    |> render("index.html")
  end

  defp model, do: model("2017-07-01", Date.to_string(Date.utc_today()))
  defp model(from_date, to_date) do
    filter = %{
      from_date: from_date,
      to_date: to_date
    }
    conversations = Repository.Conversations.list_all_conversations(filter)

    %{
      search: filter,
      average_response_time:
        Repository.Conversations.get_average(:time_to_first_response,
                                             conversations),
      average_closing_time:
        Repository.Conversations.get_average(:closing_time, conversations),
      averages_per_company:
        Repository.Conversations.conversation_averages_by_company(filter)
    }
  end
end
