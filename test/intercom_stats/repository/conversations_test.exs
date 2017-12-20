defmodule IntercomStats.Repository.ConversationsTest do
  use IntercomStatsWeb.ConnCase

  import IntercomStats.Factory

  alias IntercomStats.Repository.Conversations

  setup do
    insert(
      :conversation,
      company_name: "STMR",
      time_to_first_response: 5,
      closing_time: 120)
    insert(
      :conversation,
      company_name: "STMR",
      time_to_first_response: 20,
      closing_time: 180)
    insert(
      :conversation,
      company_name: "STMR",
      time_to_first_response: 35,
      closing_time: 60)

    :ok
  end

  describe "conversation_averages_by_company" do
    test "returns the first response average" do
      assert [%{company_name: "STMR", average_first_response: "20 seconds" }] =
        Conversations.conversation_averages_by_company()
    end

    test "returns closing time average" do
      assert [%{company_name: "STMR", average_closing_time: "2 minutes" }] =
        Conversations.conversation_averages_by_company()
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
