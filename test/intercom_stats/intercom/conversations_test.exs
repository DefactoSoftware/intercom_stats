defmodule IntercomStats.Intercom.ConversationsTest do
  use IntercomStatsWeb.ConnCase
  import IntercomStats.Factory

  alias IntercomStats.Intercom.{Tags, Conversations, Conversation}
  alias IntercomStats.Repo

  test "only conversations that are usefull are saved" do
    insert :intercom_conversation

    Tags.save_from_api
    Conversations.save_from_api

    result = Repo.all(Conversation)
    assert Enum.count(result) == 1
    assert List.first(result).id == "3"
  end
end
