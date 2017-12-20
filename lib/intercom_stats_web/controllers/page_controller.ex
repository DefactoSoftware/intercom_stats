defmodule IntercomStatsWeb.PageController do
  use IntercomStatsWeb, :controller
  use Timex

  alias IntercomStats.Intercom
  alias IntercomStats.Repository

  def index(conn, _params) do
    conn
    |> assign(:model, model)
    |> render("index.html")
  end

  def get_from_api(conn, _params) do
    Intercom.Tags.save_from_api
    Intercom.Conversations.save_from_api

    conn
    |> assign(:model, model)
    |> render("index.html")
  end

  defp model() do
    conversations = Repository.Conversations.list_all_conversations()

    model = %{
      average_response_time: get_average_time(:first_response, conversations),
      average_closing_time: get_average_time(:closing_time, conversations)
    }
  end

  defp get_average_time(:first_response, list) do
    list
    |> Enum.map(fn(%{time_to_first_response: time}) -> time end)
    |> Enum.sum
    |> to_readable_time(list)
  end

  defp get_average_time(:closing_time, list) do
    list
    |> Enum.map(fn(%{closing_time: time}) -> time end)
    |> Enum.sum
    |> to_readable_time(list)
  end

  defp to_readable_time(total, list) do
    case Enum.count(list) do
      0 -> nil
      count ->
        (total / count)
        |> Float.floor
        |> Duration.from_seconds
        |> Timex.format_duration(:humanized)
    end
  end
end
