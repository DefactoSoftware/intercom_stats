defmodule IntercomStats.Intercom.ConversationsTest do
  use IntercomStatsWeb.ConnCase
  import Ecto.Query
  alias IntercomStats.Repo
  alias IntercomStats.Intercom.Conversations
  alias IntercomStats.Intercom.Conversation
  alias IntercomStats.Intercom.Tags
  alias IntercomStats.Intercom.Segments

  test "save intercom conversation parts" do
    Tags.save_from_api
    Conversations.save_from_api

    assert Enum.count(Repo.all(Conversation)) == 1
  end

  test "save tags from conversation" do
    Tags.save_from_api
    Conversations.save_from_api

    [conversation] = Repo.all(from(p in Conversation, where: p.id == "11480005803", preload: :tags))
    assert Enum.count(conversation.tags) == 1
  end
end
