defmodule IntercomStatsWeb.PageController do
  use IntercomStatsWeb, :controller
  alias IntercomStats.Repository.Conversations
  alias IntercomStats.Intercom.Tag
  alias IntercomStats.Repo
  alias IntercomStats.Intercom.Conversation

  def index(conn, _params) do
    data =
      Repo.all(Tag)
      |> Enum.map(fn(%{id: id, name: name}) ->
        [name, Enum.count(Conversations.list_conversations_by_tags(:or, [id]))]
      end)
      |> Enum.filter(fn([name, count]) -> (count >= 1) end)
    conv_with_tags_count = data
    |> Enum.map(fn([name, count]) -> count end)
    |> Enum.sum

    total_conv = Enum.count(Repo.all(Conversation))

    data = data ++ [["no tags", total_conv - conv_with_tags_count]]
    render conn, "index.html", data: data
  end
end
