defmodule IntercomStats.Repository.ConversationsTest do
  use IntercomStatsWeb.ConnCase

  import IntercomStats.Factory

  alias IntercomStats.Repository.Conversations

  setup do
    insert :conversation, company_name: "STMR", time_to_first_response: 5
    insert :conversation, company_name: "STMR", time_to_first_response: 20
    insert :conversation, company_name: "STMR", time_to_first_response: 35

    :ok
  end

  describe "conversation_first_response_by_company" do
    test "returns a list of grouped conversations" do
      assert [%{company_name: "STMR", average_first_response: "20 seconds" }] =
        Conversations.conversation_first_response_by_company()
    end
  end

  describe "calculate average" do
    test "get_average returns a readable time" do
      conversations = Conversations.list_all_conversations()
      assert "20 seconds" ==
        Conversations.get_average(:time_to_first_response, conversations)
    end

    test "get_average returns no conversations available" do
      assert "Er zijn geen gesprekken beschikbaar" ==
        Conversations.get_average(:time_to_first_response, [])
    end

    test "calculate_average returns the average time in seconds" do
      times = [20, 10, 30]
      assert 20 == Conversations.calculate_average(Enum.sum(times), times)
    end

    test "calculate_average without conversations" do
      times = []
      assert nil == Conversations.calculate_average(Enum.sum(times), times)
    end
  end
end
