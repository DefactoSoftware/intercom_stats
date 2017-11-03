defmodule IntercomStats.Intercom.Conversations do
  alias IntercomStats.Intercom.API
  alias IntercomStats.Repo
  alias IntercomStats.Intercom.Conversation
  alias IntercomStats.Intercom.Tag

  @conversation_properties [
    "id", 
    "created_at",
    "updated_at",
    "company_name"
  ]

  def save_from_api do
    {:ok, %{body: body}} = API.get("/conversations", params: %{per_page: "60"})
    attrs = %{}
    result =
      body
      |> API.decode_json
      |> Map.get("conversations")
      |> Enum.filter(fn %{"state" => value} -> value == "closed" end)
      |> Enum.reduce([], fn (item, acc) -> [get_conversation_properties(item) | acc] end)
      #|> Enum.reduce([], fn (item, acc) -> [Map.take(item, @conversation_properties) | acc] end)
    
    IO.inspect result
    IO.puts Enum.count(result)
  end

  defp get_conversation_properties(item) do
    item
    |> Map.put("company_name", "kaas")
    |> Map.take(@conversation_properties)
  end

  defp save_conversations_list(%{"conversations" => conv_list}) do
    conv_list
    |> Enum.map(
      fn(%{"id" => id}) ->
        request_conversation(id)
      end
    )
  end

  defp request_conversation(id) do
    {:ok, %{body: body}} = API.get("/conversations/#{id}")

    body
    |> API.decode_json
    |> save_conversation
  end

  defp save_conversation(c) do
    %{"id" => id} = c
    changes = %{id: id, time_to_first_response: calc_first_time(c), tags: retrieve_tags(c)}
    %Conversation{}
    |> Conversation.changeset(changes)
    |> Repo.insert_or_update
  end

  defp calc_first_time(conv) do
    %{"created_at" => created } = conv
    %{"conversation_parts" => %{"conversation_parts" => [%{"created_at" => part_created}| _]}} = conv
    part_created - created
  end

  defp retrieve_tags(conv) do
    %{"tags" => %{"tags" => tags}} = conv
    tags
    |> Enum.map(fn(%{"id" => id}) ->
      Repo.get(Tag, id)
    end)
  end
end
