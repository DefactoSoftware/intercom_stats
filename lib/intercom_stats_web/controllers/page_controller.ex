defmodule IntercomStatsWeb.PageController do
  use IntercomStatsWeb, :controller

  alias IntercomStats.Intercom.Tags
  alias IntercomStats.Intercom.Conversations

  alias IntercomStats.Repository.{Tags, Conversations}

  def index(conn, _params) do
    [%{conversations: bugs}] = Tags.list_all_tags(%{name: "bug"})
    [%{conversations: user_support}] =
      Tags.list_all_tags(%{name: "gebruikersondersteuning"})
      
    model = %{
      bugs: %{
        average_first_response: get_average_first_to_respond_time(bugs)
      },
      support: %{
        average_first_response: get_average_first_to_respond_time(user_support)
      }
    }

    render conn, "index.html", model: model
  end

  def get_from_api(conn, _params) do
    Tags.save_from_api
    Conversations.save_from_api

    render conn, "index.html"
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
