defmodule IntercomStatsWeb.CompanyController do
  use IntercomStatsWeb, :controller
  use Timex

  alias IntercomStats.Repository.Conversations

  def show(conn,
      %{"name" => name, "from_date" => from_date, "to_date" => to_date}) do

    filter = %{
      company_name: name,
      from_date: default_from_date(from_date),
      to_date: default_to_date(to_date)
    }

    conn
    |> assign(:model, create_model(filter))
    |> render("show.html")
  end

  def show(conn, %{"name" => name}) do
    filter = %{
      company_name: name,
      from_date: default_from_date(nil),
      to_date: default_to_date(nil)
    }

    conn
    |> assign(:model, create_model(filter))
    |> render("show.html")
  end

  defp default_from_date(nil), do: "2017-07-01"
  defp default_from_date(date), do: date

  defp default_to_date(nil), do: Date.to_string(Date.utc_today())
  defp default_to_date(date), do: date

  defp create_model(filter) do
    prio1_averages =
      %{tag: "prio 1"}
      |> Map.merge(filter)
      |> Conversations.conversation_averages_by_tag_and_company()

    prio2_averages =
      %{tag: "prio 2"}
      |> Map.merge(filter)
      |> Conversations.conversation_averages_by_tag_and_company()

    prio3_averages =
      %{tag: "prio 3"}
      |> Map.merge(filter)
      |> Conversations.conversation_averages_by_tag_and_company()

    prio4_averages =
      %{tag: "prio 4"}
      |> Map.merge(filter)
      |> Conversations.conversation_averages_by_tag_and_company()

    support_averages =
      %{tag: "gebruikersondersteuning"}
      |> Map.merge(filter)
      |> Conversations.conversation_averages_by_tag_and_company()
    message_number =
      filter
      |> Conversations.conversation_number_by_company()

    model = %{
      company_name: filter.company_name,
      from_date: filter.from_date,
      to_date: filter.to_date,
      prio1_averages: prio1_averages,
      prio2_averages: prio2_averages,
      prio3_averages: prio3_averages,
      prio4_averages: prio4_averages,
      support_averages: support_averages,
      message_number: message_number
    }
  end
end
