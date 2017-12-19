defmodule IntercomStats.Repository.Conversations do
  alias IntercomStats.Intercom.Conversation
  alias IntercomStats.Repo
  alias IntercomStats.Repository.Tags
  alias IntercomStats.Repository.Segments
  import Ecto.Query
  use Timex
  import IntercomStatsWeb.Gettext

  def list_all_conversations(%{}) do
    Conversation
    |> Repo.all
  end

  def list_all_conversations(%{company_name: company_name}) do
    company = "%#{company_name}%"
    Repo.all(from c in Conversation, where: like(c.company_name, ^company))
  end

  def list_conversations_by_tags(:or, tags_list) do
    query = from t in "tags",
            join: ct in "conversations_tags", on: t.id == ct.tag_id,
            join: c in "conversations", on: ct.conversation_id == c.id,
            where: t.id in ^tags_list,
            select: %Conversation{id: c.id}
    Repo.all(query)
    |> Enum.uniq_by(fn %{id: id} -> id end)
  end

  def conversation_first_response_by_company() do
    list_all_conversations(%{})
    |> Enum.group_by(&(&1.company_name))
    |> Enum.map(fn {key, value} ->
      %{
        company_name: key,
        average_first_response: average_first_response(value)
      }
    end)
    |> Enum.sort(fn(%{company_name: a}, %{company_name: b}) ->
      String.first(a) <= String.first(b)
    end)
  end

  def average_first_response(conversations) do
    conversations
    |> Enum.map(fn(%{time_to_first_response: time}) ->
      time
    end)
    |> Enum.filter(fn(time) -> time != nil end)
    |> Enum.sum
    |> to_readable_time(conversations)
  end

  def average_closing_time(conversations) do
    conversations
    |> Enum.map(fn(%{closing_time: time}) ->
      time
    end)
    |> Enum.filter(fn(time) -> time != nil end)
    |> Enum.sum
    |> to_readable_time(conversations)
  end

  defp to_readable_time(_, list) when list == [],
    do: gettext("Er zijn geen gesprekken beschikbaar")
  defp to_readable_time(total, list) do
    round(total / Enum.count(list))
    |> Duration.from_seconds
    |> Timex.format_duration(:humanized)
  end
end
