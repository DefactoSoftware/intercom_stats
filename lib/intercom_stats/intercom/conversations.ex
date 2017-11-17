defmodule IntercomStats.Intercom.Conversations do
  alias IntercomStats.Intercom.API
  alias IntercomStats.Repo
  alias IntercomStats.Intercom.{Worker, IntercomConversation}

  def save_from_api() do
    {:ok, %{body: body}} = API.get("/conversations", params: %{per_page: "60", sort: "updated_at"})
    %{"pages" => %{"total_pages" => total_pages}} = API.decode_json(body)
    
    {:ok, pid} = Worker.start_link()
    save_page_api(pid, :init)

    #The statement to update the last_update should be moved elsewhere eventually
    Repo.insert %IntercomConversation{last_update: DateTime.utc_now}
  end

  defp save_page_api(pid, state) when state == :init do
    {page, state}  = Worker.save_page_from_api(pid, 1)
    save_page_api(pid, state, page + 1)
  end

  defp save_page_api(pid, state, page) when state == :not_done do
    {page, state} = Worker.save_page_from_api(pid, page)
    save_page_api(pid, state, page + 1)
  end

  defp save_page_api(pid, state, page) when state == :done do
    Worker.stop(pid) 
  end
end
