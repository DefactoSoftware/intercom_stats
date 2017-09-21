defmodule IntercomStats.RetrieveData.ConversationsTest do
  use IntercomStats.DataCase
  import IntercomStats.Factory

  alias IntercomStats.Repository.Conversations

    setup do
      tag1 = insert(:tag, name: "prio1")
      tag2 = insert(:tag, name: "prio2")
      tag3 = insert(:tag, name: "bug")
      tag4 = insert(:tag, name: "assistance")
      segment1 = insert(:segment, name: "Defacto")
      segment2 = insert(:segment, name: "Radboud")
      insert(:conversation, segment: segment1, tags: [tag1, tag3])
      insert(:conversation, segment: segment1, tags: [tag3, tag4])
      insert(:conversation, segment: segment2, tags: [tag2, tag3])
      {:ok, %{segment1: segment1, segment2: segment2, tag1: tag1, tag3: tag3}}
    end

    test "list_all_conversations/0 returns all conversations" do
      returned_list = Conversations.list_all_conversations
      assert Enum.count(returned_list) == 3
    end

    test "listing conversations per segment filtered on tags/or", %{segment1: segment1, tag1: tag1, tag3: tag3} do
      returned_list = Conversations.list_conversations_by_segments_and_tags(:or, [segment1.id],[tag1.id, tag3.id])
      assert Enum.count(returned_list) == 2
    end

    test "listing conversations per segment filtered on tags/and", %{segment1: segment1, tag1: tag1, tag3: tag3} do
      returned_list = Conversations.list_conversations_by_segments_and_tags(:and, [segment1.id],[tag3.id, tag1.id])
      assert Enum.count(returned_list) == 1
    end

    test "listing conversations per segment filtered on tags/and no tags", %{segment1: segment1, tag3: tag3} do
      returned_list = Conversations.list_conversations_by_segments_and_tags(:and, [segment1.id],[tag3.id])
      assert Enum.count(returned_list) == 2
    end

    test "list_conversations_by_segment/2 returns conversations filtered on segments", %{segment1: segment1, segment2: segment2} do
      result_segment = Conversations.list_conversations_by_segments([segment1.id])
      result_segments = Conversations.list_conversations_by_segments([segment1.id, segment2.id])
      assert Enum.count(result_segment) == 2
      assert Enum.count(result_segments) == 3
    end

    test "list_conversations_by_tags/2 returns conversations filtered on tags", %{tag1: tag1, tag3: tag3} do
      result_tags = Conversations.list_conversations_by_tags(:or, [tag1.id, tag3.id])
      assert Enum.count(result_tags) == 3
    end
end
