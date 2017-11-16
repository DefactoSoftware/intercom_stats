defmodule IntercomStats.Intercom.Conversations do
  alias IntercomStats.Intercom.API
  alias IntercomStats.Repo
  alias IntercomStats.Intercom.{Conversation, Tag, IntercomConversation}

  @conversation_properties [
    "id", 
    "created_at",
    "updated_at",
    "company_name",
  ]

  def save_from_api(page \\ 1) do
    {:ok, %{body: body}} = API.get("/conversations", params: %{per_page: "60", page: page})

    result =
      body
      |> API.decode_json
      |> Map.get("conversations")
      |> Enum.filter(fn %{"state" => value} -> value == "closed" end)
      |> Enum.reduce([], fn (item, acc) -> [get_conversation_properties(item) | acc] end)
      |> Enum.reduce([], fn (item, acc) -> [get_conversation_specific_properties(item) | acc] end)   

    Repo.insert %IntercomConversation{last_update: DateTime.utc_now}
  end

  defp get_conversation_properties(item) do
    item
    |> Map.put("company_name", "company_name_from_CAPP")
    |> Map.take(@conversation_properties)
    #Note: As soon as the company name is provided, the Map.Put can be removed
  end

  defp get_conversation_specific_properties(item) do
    conversation = request_conversation(item)

    tags = retrieve_tags_for_conversation(conversation)
    time_to_first_response = calculate_time_to_first_response(conversation)
    closing_time = calculate_closing_time(conversation)

    item
    |> Map.put("tags", tags)
    |> Map.put("time_to_first_response", time_to_first_response)
    |> Map.put("closing_time", closing_time)
  end

  defp request_conversation(%{"id" => id}) do
    {:ok, %{body: body}} = API.get("/conversations/#{id}")
    API.decode_json(body)
  end

  defp retrieve_tags_for_conversation(conversation) do
    %{"tags" => %{"tags" => tags}} = conversation

    tags 
    |> Enum.map(fn(%{"id" => id}) -> Repo.get(Tag, id) end)
  end

  defp calculate_time_to_first_response(conversation) do
    %{"created_at" => created } = conversation
    %{"conversation_parts" => %{"conversation_parts" => [%{"created_at" => part_created}| _]}} = conversation
    part_created - created
  end

  defp calculate_closing_time(conversation) do
    %{"created_at" => created, "updated_at" => updated} = conversation
    updated - created
  end

  defp save_conversation(c) do
    %Conversation{}
    |> Conversation.changeset(c)
    |> Repo.insert_or_update
  end
end
