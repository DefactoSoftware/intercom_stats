defmodule IntercomStats.Intercom.Conversations do
  alias IntercomStats.Repo
  alias IntercomStats.Intercom.{Conversation, API, Worker, IntercomConversation}

  def save_from_api() do
    {:ok, pid} = Worker.start_link()

    {:ok, %{body: body}} = API.get("/conversations",
                                   params: %{per_page: "60",
                                   page: 1})

    %{"pages" => %{"total_pages" => total_pages}} = API.decode_json(body)
    save_page_api(pid, :init, total_pages)

    #The statement to update the last_update should be moved elsewhere eventually
    Repo.insert %IntercomConversation{last_update: DateTime.utc_now}
  end

  defp save_page_api(pid, state, max_pages) when state == :init do
    {page, state}  = Worker.save_page_from_api(pid, 1)

    cond do
      page == max_pages -> Worker.stop(pid)
      true -> save_page_api(pid, state, page + 1, max_pages)
    end
    state
  end

  defp save_page_api(pid, state, page, max_pages) when state == :not_done do
    {page, state} = Worker.save_page_from_api(pid, page)
    save_page_api(pid, state, page + 1, max_pages)
  end

  defp save_page_api(pid, state, page, max_pages) when state == :done do
    Worker.stop(pid)
  end
end