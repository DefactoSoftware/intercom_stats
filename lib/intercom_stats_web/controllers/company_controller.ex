defmodule IntercomStatsWeb.CompanyController do
  use IntercomStatsWeb, :controller

  alias IntercomStats.Repository.Conversations

  def show(conn, %{"name" => name}) do
    conversations = Conversations.list_all_conversations(%{company_name: name})

    model = %{
      company_name: name
    }

    conn
    |> assign(:model, model)
    |> render("show.html")
  end
end
