defmodule IntercomStats.Intercom.ConversationsTest do
  use IntercomStatsWeb.ConnCase
  import IntercomStats.Factory

  alias IntercomStats.Intercom.{IntercomConversation, Tags, Conversations, Conversation}
  alias IntercomStats.Repo

  test "only correct and complete conversations are stored" do
    insert :intercom_conversation

    Tags.save_from_api
    Conversations.save_from_api

    result = Repo.all(Conversation)
    assert Enum.count(result) == 5
  end

  test "correct values are stored for conversation/3" do
    insert :intercom_conversation

    Tags.save_from_api
    Conversations.save_from_api

    conversation = Repo.get(Conversation, "3")

    assert conversation.id == "3"
    assert conversation.company_name == "company_name_2"
    assert conversation.closing_time == 28008
    assert conversation.time_to_first_response == 18006
    assert conversation.average_response_time == 9007
    assert conversation.total_response_time == 18014
    assert conversation.closed_timestamp == 1500030008
    assert conversation.open_timestamp == 1500002000
  end

  test "correct values are stored for conversation/5" do
    insert :intercom_conversation

    Tags.save_from_api
    Conversations.save_from_api

    conversation = Repo.get(Conversation, "5")

    assert conversation.id == "5"
    assert conversation.company_name == "company_name_2"
    assert conversation.closing_time == 28008
    assert conversation.time_to_first_response == 18001
    assert conversation.average_response_time == 9005
    assert conversation.total_response_time == 18009
    assert conversation.closed_timestamp == 1500030008
    assert conversation.open_timestamp == 1500002000
  end

  test "correct values are stored for conversation/6" do
    insert :intercom_conversation

    Tags.save_from_api
    Conversations.save_from_api

    conversation = Repo.get(Conversation, "6")

    assert conversation.id == "6"
    assert conversation.company_name == "company_name_2"
    assert conversation.closing_time == 28008
    assert conversation.time_to_first_response == 18006
    assert conversation.average_response_time == 18006
    assert conversation.total_response_time == 18006
    assert conversation.closed_timestamp == 1500030008
    assert conversation.open_timestamp == 1500002000
  end

  test "providing the same conversation twice results into an update" do
    insert :intercom_conversation

    Tags.save_from_api
    Conversations.save_from_api

    {:ok, updated_conversation} = 
      Repo.get(Conversation, "3")
      |> Ecto.Changeset.change(%{closing_time: 2000})
      |> Repo.update()

    assert updated_conversation.closing_time == 2000

    Repo.all(IntercomConversation)
    |> List.last
    |> Repo.delete

    Conversations.save_from_api
    conversation = Repo.get(Conversation, "3")

    assert conversation.id == "3"
    assert conversation.company_name == "company_name_2"
    assert conversation.closing_time == 28008
    assert conversation.time_to_first_response == 18006
    assert conversation.average_response_time == 9007
    assert conversation.total_response_time == 18014
    assert conversation.closed_timestamp == 1500030008
    assert conversation.open_timestamp == 1500002000
  end

  test "user starts and replies initially" do
    insert :intercom_conversation

    Tags.save_from_api
    Conversations.save_from_api

    conversation = Repo.get(Conversation, "7")

    assert conversation.id == "7"
    assert conversation.company_name == "company_name_2"
    assert conversation.closing_time == 28008
    assert conversation.time_to_first_response == 9994
    assert conversation.average_response_time == 9994
    assert conversation.total_response_time == 9994
    assert conversation.closed_timestamp == 1500030008
    assert conversation.open_timestamp == 1500002000
  end
end
