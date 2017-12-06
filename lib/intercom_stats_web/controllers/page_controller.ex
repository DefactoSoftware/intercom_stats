defmodule IntercomStatsWeb.PageController do
  use IntercomStatsWeb, :controller

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
    [%{conversations: bugs}] = Repository.Tags.list_all_tags(%{name: "bug"})
    [%{conversations: user_support}] =
      Repository.Tags.list_all_tags(%{name: "gebruikersondersteuning"})

    model = %{
      bugs: %{
        average_first_response: get_average_first_to_respond_time(bugs)
      },
      support: %{
        average_first_response: get_average_first_to_respond_time(user_support)
      }
    }
  end

  defp get_average_first_to_respond_time(list) do
    total = Enum.map(list, fn(%{time_to_first_response: time}) ->
      time
    end)
    |> Enum.sum

    {val, _} =
      (total / Enum.count(list)) / 60
      |> Kernel.inspect
      |> Integer.parse

    val
  end
end
