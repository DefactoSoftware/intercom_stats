defmodule IntercomStats.Repository.Conversations do
  use Timex

  import Ecto.Query
  import IntercomStatsWeb.Gettext

<<<<<<< HEAD
  def list_all_conversations(%{}), do: list_all_conversations
  def list_all_conversations() do
    Repo.all(Conversation)
=======
  alias IntercomStats.Intercom.Conversation
  alias IntercomStats.Repo

  def list_all_conversations(%{}) do
    Conversation
    |> Repo.all
>>>>>>> Refactor the get average lists
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

  def conversation_averages_by_company() do
    list_all_conversations()
    |> Enum.group_by(&(&1.company_name))
    |> Enum.map(fn {key, value} ->
      %{
        company_name: key,
        average_first_response: get_average(:time_to_first_response, value),
        average_closing_time: get_average(:closing_time, value)
      }
    end)
    |> Enum.sort(fn(%{company_name: a}, %{company_name: b}) ->
      String.capitalize(a) <= String.capitalize(b)
    end)
  end

  def get_average(key, conversations) do
    conversations
    |> Enum.map(fn(conversation) ->
        Map.get(conversation, key)
      end)
    |> Enum.filter(fn(time) -> time != nil end)
    |> Enum.sum
    |> calculate_average(conversations)
    |> to_readable_time()
  end

  def calculate_average(_, [] = list), do: nil
  def calculate_average(total, list) do
    round(total / Enum.count(list))
  end

  defp to_readable_time(seconds) when seconds == nil,
    do: gettext("Er zijn geen gesprekken beschikbaar")
  defp to_readable_time(seconds) do
    seconds
    |> Duration.from_seconds
    |> Timex.format_duration(:humanized)
  end
end
