defmodule IntercomStats.Repository.Conversations do
  alias IntercomStats.Intercom.Conversation
  alias IntercomStats.Repo
  alias IntercomStats.Repository.Tags
  alias IntercomStats.Repository.Segments
  import Ecto.Query
  use Timex

  def list_all_conversations(%{}) do
    Repo.all(Conversation)
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
      total = value
              |> Enum.map(fn(%{time_to_first_response: first}) ->
                first
              end)
              |> Enum.filter(fn(time) -> time != nil end)
              |> Enum.sum

      %{
        company_name: key,
        average_first_response: round(total / Enum.count(value)) |> Duration.from_seconds |> Timex.format_duration(:humanized)
      }
    end)
  end
end
