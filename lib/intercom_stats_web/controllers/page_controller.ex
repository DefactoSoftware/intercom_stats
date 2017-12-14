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

  def search(conn, %{"search" => %{"from_date" => from_date, "to_date" => to_date}}) do
    conn
    |> assign(:model, model(from_date, to_date))
    |> render("index.html")
  end

  defp model(), do: model("", "")
  defp model(from_date, to_date) do
    conversations = Repository.Conversations.list_all_conversations(%{})

    %{
      search: %{
        from_date: from_date,
        to_date: to_date
      },
      average_response_time:
        Repository.Conversations.get_average(:time_to_first_response, conversations),
      average_closing_time:
        Repository.Conversations.get_average(:closing_time, conversations)
    }
  end
end
