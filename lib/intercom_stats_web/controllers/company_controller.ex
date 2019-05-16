defmodule IntercomStatsWeb.CompanyController do
  use IntercomStatsWeb, :controller
  use Timex

  alias IntercomStats.Repository.Conversations

  def show(
        conn,
        %{"name" => name, "from_date" => from_date, "to_date" => to_date}
      ) do
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
  defp add_to_model(key, value, model), do: put(model, key, value)
  taglist = ["prio 1", "prio 2", "prio 3", "prio 4", "prio 5", "gebruikersondersteuning"]

  defp create_model(filter) do
    untagged_averages =
      %{tag: nil}
      |> Map.merge(filter)
      |> Conversations.conversation_stats_by_tag_and_company()

    total_averages = Conversations.conversation_stats_by_tag_and_company(filter)

    message_number = Conversations.conversation_number_by_company(filter)

    model = %{
      company_name: filter.company_name,
      from_date: filter.from_date,
      to_date: filter.to_date,
      total_averages: total_averages,
      untagged_averages: untagged_averages,
      message_number: message_number
    }

    Enum.each(taglist, fn x ->
      averages =
        %{tag: x}
        |> Map.merge(filter)
        |> Conversations.conversation_stats_by_tag_and_company()

      String.trim(x)
      |> String.to_atom()
      |> add_to_model(averages, model)
    end)
  end
end
