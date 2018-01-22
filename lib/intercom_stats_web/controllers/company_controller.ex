defmodule IntercomStatsWeb.CompanyController do
  use IntercomStatsWeb, :controller

  alias IntercomStats.Repository.Conversations

  def show(conn, %{"name" => name}) do
    bug_averages = Conversations.conversation_averages_by_tag_and_company(%{
      tag: "bug",
      company_name: name
    })

    support_averages = Conversations.conversation_averages_by_tag_and_company(%{
      tag: "gebruikersondersteuning",
      company_name: name
    })

    model = %{
      company_name: name,
      bug_averages: bug_averages,
      support_averages: support_averages
    }

    conn
    |> assign(:model, model)
    |> render("show.html")
  end
end
