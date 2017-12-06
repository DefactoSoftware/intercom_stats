defmodule IntercomStats.Intercom.ConversationsTest do
  use IntercomStatsWeb.ConnCase
  import IntercomStats.Factory

  alias IntercomStats.Intercom.{Tags, Conversations, Conversation}
  alias IntercomStats.Repo

  test "only correct and complete conversations are stored" do
    insert :intercom_conversation

    Tags.save_from_api
    Conversations.save_from_api

    result = Repo.all(Conversation)
    assert Enum.count(result) == 1
    assert List.first(result).id == "3"
  end

  test "correct values are stored for conversations" do
    insert :intercom_conversation

    Tags.save_from_api
    Conversations.save_from_api

    conversation = Repo.get(Conversation, "3")

    assert conversation.id == "3"
    assert conversation.company_name == "company_name_2"
    assert conversation.closing_time == 7000
    assert conversation.time_to_first_response == 18006
    assert conversation.average_response_time == 9007
  end
end
