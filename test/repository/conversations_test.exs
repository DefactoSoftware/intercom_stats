defmodule IntercomStats.RetrieveData.ConversationsTest do
  use IntercomStats.DataCase
  import IntercomStats.Factory

  alias IntercomStats.Repository.Conversations

    test "list_all_conversations/0 returns all conversations" do
      insert(:conversation, segment: build(:segment, name: "Defacto"))
      insert(:conversation, segment: build(:segment, name: "Defacto"))
      insert(:conversation, segment: build(:segment, name: "Radboud"))

      returned_list = Conversations.list_all_conversations
      assert Enum.count(returned_list) == 3
    end
end
