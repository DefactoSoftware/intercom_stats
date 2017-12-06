defmodule IntercomStats.Intercom.Worker do
  use GenServer
  alias IntercomStats.Intercom.API
  alias IntercomStats.Intercom.{Tag, Conversation, IntercomConversation}
  alias IntercomStats.Repo

  import Ecto.Query

  @conversation_properties [
    "id",
    "created_at",
    "updated_at"
  ]

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def save_page_from_api(pid, page) do
    GenServer.call(pid, {:page, page}, 60000000)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def stop(pid) do
    GenServer.cast(pid, :stop)
  end

  def handle_call({:page, page}, _from, _state) do
    process_api_records(page)
  end

  def handle_cast(:stop, _state) do
    {:stop, :normal, _state}
  end

  def terminate(reason, _state) do
    IO.puts "Server terminated because of #{inspect reason}"
    :ok
  end

  defp process_api_records(page) do
    {:ok, %{body: body}} = API.get("/conversations",
                                   params: %{per_page: "60",
                                   page: page,
                                   sort: "updated_at"})

    last_update = retrieve_last_update()

    result =
      body
      |> API.decode_json
      |> Map.get("conversations")
      |> Enum.filter(fn %{"state" => value} -> value == "closed" end)
      |> Enum.filter(fn %{"updated_at" => value} -> NaiveDateTime.compare(
           last_update, from_unix_to_datetime(value)) == :lt end)
      |> Enum.reduce([], fn (item, acc) ->
           [get_conversation_properties(item) | acc] end)
      |> Enum.reduce([], fn (item, acc) ->
           [get_conversation_specific_properties(item) | acc] end)
      |> Enum.filter(fn %{"tags" => tags} -> Enum.any?(tags) end)

    Enum.each(result, fn conversation -> insert_conversation(conversation) end)

    case List.last(result) do
      %{"updated_at" => last_update_in_list} ->
        case NaiveDateTime.compare(
               last_update, from_unix_to_datetime(last_update_in_list)) do
          :lt -> {:reply, {page, :not_done}, page}
          _ -> {:reply, {page, :done}, page}
        end
      _ -> {:reply, {page, :done}, page}
    end
  end

  defp get_conversation_properties(item) do
    item
    |> Map.take(@conversation_properties)
  end
  defp get_conversation_specific_properties(item) do
    conversation = request_conversation(item)
    response_times = calculate_response_times(conversation)

    item
    |> Map.put("company_name", retrieve_company_name(conversation))
    |> Map.put("tags", retrieve_tags_for_conversation(conversation))
    |> Map.put("time_to_first_response", first_response_time(response_times))
    |> Map.put("closing_time", calculate_closing_time(conversation))
    |> Map.put("average_response_time", average_response_time(response_times))
  end

  defp request_conversation(%{"id" => id}) do
    {:ok, %{body: body}} = API.get("/conversations/#{id}")
    API.decode_json(body)
  end

  def retrieve_company_name(%{"user" => %{"id" => id}}) do
    {:ok, %{body: body}} = API.get("/users/#{id}")
    case API.decode_json(body) do
      %{"companies" => %{"companies" => [%{"name" => name} | _]}} -> name
      _ -> "Unknown"
    end
  end

  defp retrieve_tags_for_conversation(conversation) do
    %{"tags" => %{"tags" => tags}} = conversation

    tags
    |> Enum.map(fn(%{"id" => id}) -> Repo.get(Tag, id) end)
  end

  defp first_response_time(response_times) do
    with [head | _] <- response_times, do: head, else: (_ -> nil)
  end

  defp average_response_time(response_times) do
    with [_ | _] <- response_times do
      round(Enum.sum(response_times) / Enum.count(response_times))
    else
      _ -> nil
    end
  end

  defp calculate_closing_time(conversation) do
    %{"created_at" => created, "updated_at" => updated} = conversation
    updated - created
  end

  defp calculate_response_times(conversation) do
    %{"conversation_parts" => %{"conversation_parts" => parts}} = conversation
    parts = [Map.take(conversation, ["author", "body", "created_at"]) | parts]

    {response_times, _} = Enum.flat_map_reduce(parts, %{}, fn(i, acc) ->
      with :ok <- is_response_type(i, "admin"),
           :ok <- is_response_type(acc, "user") do
        {[calculate_response_time(i, acc)], i}
      else
        :empty_response -> {[], acc}
        _ -> {[], i}
      end
    end)

    response_times
  end
  
  defp is_response_type(conversation_part, type) do
    case conversation_part do
      %{"author" => %{"type" => ^type}, "body" => body} when is_binary(body) -> :ok
      %{"author" => %{"type" => ^type}, "body" => body} when is_nil(body) -> :empty_response
      _ -> :not_found
    end
  end

  defp calculate_response_time(%{"created_at" => new_time}, %{"created_at" => old_time}) do
    new_time - old_time 
  end

  defp retrieve_last_update() do
    intercom_conversation = from(i in IntercomConversation, limit: 1, order_by: [desc: i.id]) |> Repo.one
    case intercom_conversation do
      nil -> ~N[2000-01-01 00:00:00]
      _ -> intercom_conversation.last_update
    end
  end

  defp from_unix_to_datetime(unix_value) do
    {:ok, datetime} = DateTime.from_unix(unix_value)
    datetime
  end

  def insert_conversation(attrs) do
    {:ok, conversation} = Repo.insert(Conversation.changeset(%Conversation{}, attrs))

    conversation
    |> Repo.preload(:tags)
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:tags, attrs["tags"])
    |> Repo.update!
  end
end
