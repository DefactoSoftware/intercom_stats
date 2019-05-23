defmodule IntercomStatsWeb.CompanyController do
  use IntercomStatsWeb, :controller
  use Timex

  alias IntercomStats.Repository.Conversations

  versiontags = %{
    "CAPP11" => [
      "prio 1",
      "prio 2",
      "prio 3",
      "prio 4",
      "prio 5",
      "support",
      "gebruikersondersteuning",
      "consultancy"
    ],
    "CAPP12" => ["Bug hoog", "Bug midden", "Bug laag", "Gebruikersondersteuning", "Wens"]
  }

  @taglist Map.get(versiontags, System.get_env("TAGS"))

  IO.puts(@taglist)

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
    |> assign(:total_model, create_total_model(filter))
    |> assign(:tag_models, create_tag_models(filter))
    |> render("show.html")
  end

  def show(conn, %{"name" => name}) do
    filter = %{
      company_name: name,
      from_date: default_from_date(nil),
      to_date: default_to_date(nil)
    }

    conn
    |> assign(:total_model, create_total_model(filter))
    |> assign(:tag_models, create_tag_models(filter))
    |> render("show.html")
  end

  defp default_from_date(nil), do: "2017-07-01"
  defp default_from_date(date), do: date

  defp default_to_date(nil), do: Date.to_string(Date.utc_today())
  defp default_to_date(date), do: date

  defp add_to_model(key, value, tagmodel) do
    Map.put(tagmodel, key, value)
  end

  defp create_tag_models(filter) do
    @taglist
    |> Enum.map(fn tag ->
      %{tag: tag, stats: generate_stats(filter, tag)}
    end)
  end

  defp generate_stats(filter, tag) do
    %{tag: tag}
    |> Map.merge(filter)
    |> Conversations.conversation_stats_by_tag_and_company()
  end

  defp create_total_model(filter) do
    untagged_averages = generate_stats(filter, nil)

    total_averages = Conversations.conversation_stats_by_tag_and_company(filter)

    message_number = Conversations.conversation_number_by_company(filter)

    %{
      company_name: filter.company_name,
      from_date: filter.from_date,
      to_date: filter.to_date,
      total_averages: total_averages,
      untagged_averages: untagged_averages,
      message_number: message_number
    }
  end
end
