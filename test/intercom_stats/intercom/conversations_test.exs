defmodule IntercomStats.Intercom.ConversationsTest do
  use IntercomStatsWeb.ConnCase
  import IntercomStats.Factory

  alias Ecto.Changeset
  alias IntercomStats.Intercom.{Conversation, Conversations, IntercomConversation, Tags}
  alias IntercomStats.Repo

  test "only correct and complete conversations are stored" do
    insert(:intercom_conversation)

    Tags.save_from_api()
    Conversations.save_from_api()

    result = Repo.all(Conversation)
    assert Enum.count(result) == 6
  end

  test "correct values are stored for conversation/3" do
    insert(:intercom_conversation)

    Tags.save_from_api()
    Conversations.save_from_api()

    conversation = Repo.get(Conversation, "3")

    assert conversation.id == "3"
    assert conversation.company_name == "company_name_2"
    assert conversation.closing_time == 28_008
    assert conversation.time_to_first_response == 18_006
    assert conversation.average_response_time == 9_007
    assert conversation.total_response_time == 18_014
    assert conversation.closed_timestamp == 1_500_030_008
    assert conversation.open_timestamp == 1_500_002_000
  end

  test "correct values are stored for conversation/5" do
    insert(:intercom_conversation)

    Tags.save_from_api()
    Conversations.save_from_api()

    conversation = Repo.get(Conversation, "5")

    assert conversation.id == "5"
    assert conversation.company_name == "company_name_2"
    assert conversation.closing_time == 28_008
    assert conversation.time_to_first_response == 18_001
    assert conversation.average_response_time == 9_005
    assert conversation.total_response_time == 18_009
    assert conversation.closed_timestamp == 1_500_030_008
    assert conversation.open_timestamp == 1_500_002_000
  end

  test "correct values are stored for conversation/6" do
    insert(:intercom_conversation)

    Tags.save_from_api()
    Conversations.save_from_api()

    conversation = Repo.get(Conversation, "6")

    assert conversation.id == "6"
    assert conversation.company_name == "company_name_2"
    assert conversation.closing_time == 28_008
    assert conversation.time_to_first_response == 18_006
    assert conversation.average_response_time == 18_006
    assert conversation.total_response_time == 18_006
    assert conversation.closed_timestamp == 1_500_030_008
    assert conversation.open_timestamp == 1_500_002_000
  end

  test "providing the same conversation twice results into an update" do
    insert(:intercom_conversation)

    Tags.save_from_api()
    Conversations.save_from_api()

    {:ok, updated_conversation} =
      Conversation
      |> Repo.get("3")
      |> Changeset.change(%{closing_time: 2_000})
      |> Repo.update()

    assert updated_conversation.closing_time == 2_000

    IntercomConversation
    |> Repo.all()
    |> List.last()
    |> Repo.delete()

    Conversations.save_from_api()
    conversation = Repo.get(Conversation, "3")

    assert conversation.id == "3"
    assert conversation.company_name == "company_name_2"
    assert conversation.closing_time == 28_008
    assert conversation.time_to_first_response == 18_006
    assert conversation.average_response_time == 9_007
    assert conversation.total_response_time == 18_014
    assert conversation.closed_timestamp == 1_500_030_008
    assert conversation.open_timestamp == 1_500_002_000
  end

  test "user starts and replies initially" do
    insert(:intercom_conversation)

    Tags.save_from_api()
    Conversations.save_from_api()

    conversation = Repo.get(Conversation, "7")

    assert conversation.id == "7"
    assert conversation.company_name == "company_name_2"
    assert conversation.closing_time == 28_008
    assert conversation.time_to_first_response == 9_994
    assert conversation.average_response_time == 9_994
    assert conversation.total_response_time == 9_994
    assert conversation.closed_timestamp == 1_500_030_008
    assert conversation.open_timestamp == 1_500_002_000
  end

  test "correct values are stored for conversation/8" do
    insert(:intercom_conversation)

    Tags.save_from_api()
    Conversations.save_from_api()

    conversation = Repo.get(Conversation, "8")

    assert conversation.id == "8"
    assert conversation.company_name == "company_name_2"
    assert conversation.closing_time == 28_009
    assert conversation.time_to_first_response == 18_002
    assert conversation.average_response_time == 9_005
    assert conversation.total_response_time == 18_010
    assert conversation.closed_timestamp == 1_500_030_009
    assert conversation.open_timestamp == 1_500_002_000
  end

  test "correct values are stored for conversation/9" do
    insert(:intercom_conversation)

    Tags.save_from_api()
    Conversations.save_from_api()

    conversation = Repo.get(Conversation, "9")

    assert conversation.id == "9"
    assert conversation.company_name == "company_name_2"
    assert conversation.closing_time == 18_012
    assert conversation.time_to_first_response == 18_006
    assert conversation.average_response_time == 9_007
    assert conversation.total_response_time == 18_014
    assert conversation.closed_timestamp == 1_500_030_008
    assert conversation.open_timestamp == 1_500_002_000
  end
end
