defmodule IntercomStats.Repository.ConversationsTest do
  use IntercomStatsWeb.ConnCase

  import IntercomStats.Factory

  alias IntercomStats.Repository.{Conversations}

  setup do
    insert :conversation, company_name: "STMR", time_to_first_response: 5
    insert :conversation, company_name: "STMR", time_to_first_response: 20
    insert :conversation, company_name: "STMR", time_to_first_response: 35

    :ok
  end

  describe "conversation_first_response_by_company" do
    test "returns a list of grouped conversations" do
      assert [%{company_name: "STMR", average_first_response: 20 }] =
        Conversations.conversation_first_response_by_company()
    end
  end
end
