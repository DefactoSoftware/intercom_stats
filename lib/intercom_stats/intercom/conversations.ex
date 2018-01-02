defmodule IntercomStats.Intercom.Conversations do
  @moduledoc """
  Module containing functions to initiate the process of saving Intercom
  API Conversations per page
  """

  alias IntercomStats.Repo
  alias IntercomStats.Intercom.{
    API,
    Conversation,
    IntercomConversation,
    Tag,
    Worker
  }

  def save_from_api do
    :ets.new(:tags_list, [:named_table])
    :ets.insert(:tags_list, {"tags", Repo.all(Tag)})

    {:ok, pid} = Worker.start_link()

    {:ok, %{body: body}} = API.get("/conversations",
                                   params: %{per_page: "60",
                                   page: 1})

    %{"pages" => %{"total_pages" => total_pages}} = API.decode_json(body)
    save_page_api(pid, :init, total_pages)

    Repo.insert %IntercomConversation{last_update: DateTime.utc_now}
    :ets.delete(:tags_list)
  end

  defp save_page_api(pid, state, max_pages) when state == :init do
    {page, state}  = Worker.save_page_from_api(pid, 1)

    if page == max_pages do
      Worker.stop(pid)
    else
      save_page_api(pid, state, page + 1, max_pages)
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
