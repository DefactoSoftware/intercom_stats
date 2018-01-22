defmodule IntercomStatsWeb.CompanyController do
  use IntercomStatsWeb, :controller
  use Timex

  alias IntercomStats.Repository.Conversations

  def show(conn,
      %{"name" => name, "from_date" => from_date, "to_date" => to_date}) do
    filter = %{
      company_name: name,
      from_date: from_date,
      to_date: to_date
    }

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

    model = %{
      company_name: name,
      from_date: from_date,
      to_date: to_date,
      prio1_averages: prio1_averages,
      prio2_averages: prio2_averages,
      prio3_averages: prio3_averages,
      prio4_averages: prio4_averages,
      support_averages: support_averages
    }

    conn
    |> assign(:model, model)
    |> render("show.html")
  end
end
