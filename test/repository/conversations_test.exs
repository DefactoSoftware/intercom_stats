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
      insert(:conversation, segment: segment1, tags: [tag1, tag4])
      insert(:conversation, segment: segment2, tags: [tag2, tag3])
      :ok
    end

    test "list_all_conversations/0 returns all conversations" do
      returned_list = Conversations.list_all_conversations
      assert Enum.count(returned_list) == 3
    end

    test "listing conversations per segment filtered on tags/or" do
      returned_list = Conversations.list_conversations_by_segments_and_tags(:or, ["Defacto"],["prio1", "bug"])
      assert Enum.count(returned_list) == 2
    end

    test "listing conversations per segment filtered on tags/and" do
      returned_list = Conversations.list_conversations_by_segments_and_tags(:and, ["Defacto"],["prio1", "bug"])
      assert Enum.count(returned_list) == 1
    end

    test "list_conversations_by_segment/2 returns conversations filtered on segments" do
      result_segment = Conversations.list_conversations_by_segments(["Defacto"])
      result_segments = Conversations.list_conversations_by_segments(["Defacto", "Radboud"])
      assert Enum.count(result_segment) == 2
      assert Enum.count(result_segments) == 3
    end

    test "list_conversations_by_tags/2 returns conversations filtered on tags" do
      result_tags = Conversations.list_conversations_by_tags(:or, ["prio1", "bug"])
      assert Enum.count(result_tags) == 3
    end
end
