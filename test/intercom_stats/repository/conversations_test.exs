defmodule IntercomStats.Repository.ConversationsTest do
  use IntercomStatsWeb.ConnCase
  use Timex

  import IntercomStats.Factory

  alias IntercomStats.Repository.Conversations

  setup do
    insert(:conversation_bug,
      company_name: "CompanyX",
      time_to_first_response: 5,
      closing_time: 120,
      open_timestamp: DateTime.to_unix(Timex.shift(Timex.now(), days: -10)),
      closed_timestamp: DateTime.to_unix(Timex.shift(Timex.now(), days: -8))
    )

    insert(:conversation_support,
      company_name: "CompanyX",
      time_to_first_response: 20,
      closing_time: 180,
      open_timestamp: DateTime.to_unix(Timex.shift(Timex.now(), days: -15)),
      closed_timestamp: DateTime.to_unix(Timex.shift(Timex.now(), days: -10))
    )

    insert(:conversation_bug,
      company_name: "CompanyX",
      time_to_first_response: 35,
      closing_time: 60,
      open_timestamp: DateTime.to_unix(Timex.shift(Timex.now(), days: -18)),
      closed_timestamp: DateTime.to_unix(Timex.shift(Timex.now(), days: -17))
    )

    :ok
  end

  describe "conversation_averages_by_company" do
    test "returns the first response average" do
      assert [%{company_name: "CompanyX", average_first_response: "20 seconds"}] =
               Conversations.conversation_averages_by_company()
    end

    test "returns closing time average" do
      assert [%{company_name: "CompanyX", average_closing_time: "2 minutes"}] =
               Conversations.conversation_averages_by_company()
    end
  end

  describe "calculate average" do
    test "get_average returns a readable time" do
      conversations = Conversations.list_all_conversations()
      assert "20 seconds" == Conversations.get_average(:time_to_first_response, conversations)
    end

    test "get_average returns no conversations available" do
      assert "Er zijn geen gesprekken beschikbaar" ==
               Conversations.get_average(:time_to_first_response, [])
    end

    test "calculate_average returns the average time in seconds" do
      times = [20, 10, 30]
      assert 20 == Conversations.calculate_average(times)
    end

    test "calculate_average without conversations" do
      times = []
      assert nil == Conversations.calculate_average(times)
    end
  end

  describe "date selection" do
    test "string_date_to_unix" do
      date =
        Timex.today()
        |> Timex.shift(days: -13)
        |> Date.to_string()

      expectation =
        Timex.today()
        |> Timex.shift(days: -13)
        |> Timex.to_datetime()
        |> DateTime.to_unix()

      assert expectation == Conversations.string_date_to_unix(date)
    end

    test "get all conversations between a selected date range" do
      from_date =
        Timex.today()
        |> Timex.shift(days: -13)
        |> Date.to_string()

      date_range = %{
        from_date: from_date,
        to_date: Timex.today() |> Date.to_string()
      }

      conversations = Conversations.list_all_conversations(date_range)
      assert [%{time_to_first_response: 5}] = conversations
    end

    test "conversations per company" do
      from_date =
        Timex.today()
        |> Timex.shift(days: -13)
        |> Date.to_string()

      date_range = %{
        from_date: from_date,
        to_date: Timex.today() |> Date.to_string()
      }

      conversations = Conversations.conversation_averages_by_company(date_range)
      assert [%{average_first_response: "5 seconds"}] = conversations
    end
  end

  test "conversations per tag and company" do
    filter = %{
      tag: "bug",
      company_name: "CompanyX"
    }
    conversations = Conversations.list_all_conversations(filter)

    assert Enum.count(conversations) == 2
  end

  test "averages per tag and company" do
    filter = %{
      tag: "bug",
      company_name: "CompanyX",
      from_date: from_date(-13),
      to_date: Timex.today() |> Date.to_string()
    }
    conversations = Conversations.conversation_stats_by_tag_and_company(filter)

    assert %{average_first_response: "5 seconds"} = conversations
  end

  test "Number of conversations total" do
    conversations = Conversations.list_all_conversations()
    assert 3 == Conversations.get_number(conversations)
  end

  test "Number of conversations per company" do
    filter = %{
      company_name: "CompanyX"
    }
    assert %{company_name: "CompanyX", number: 3} == Conversations.conversation_number_by_company(filter)
  end

  defp from_date(days) do
    Timex.today
    |> Timex.shift(days: days)
    |> Date.to_string
  end
end
