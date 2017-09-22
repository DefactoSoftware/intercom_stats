defmodule IntercomStats.Repository.Conversations do
  alias IntercomStats.Intercom.Conversation
  alias IntercomStats.Repo
  alias IntercomStats.Repository.Tags
  alias IntercomStats.Repository.Segments
  import Ecto.Query

  def list_all_conversations() do
    Repo.all(Conversation)
  end

  def list_conversations_by_segments(segments_list) do
    query = from s in "segments",
            join: c in "conversations", on: s.id == c.segment_id,
            where: s.id in ^segments_list,
            select: %Conversation{id: c.id}
    Repo.all(query)
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

  def list_conversations_by_tags(:and, tags_list) do

    initial_query_tags(tags_list)
    |> Repo.all()
  end

  def list_conversations_by_segments_and_tags(operator, segments_list, tags_list) do
    seg_list = list_conversations_by_segments(segments_list)
    tag_list = list_conversations_by_tags(operator, tags_list)
    seg_list -- (seg_list -- tag_list)
  end

  defp initial_query_tags([head | tail]) do
    query = from c in "conversations",
            join: ct in "conversations_tags", on: c.id == ct.conversation_id,
            where: ct.tag_id == ^head
    initial_query_tags(tail, query)
  end

  defp initial_query_tags([], query) do
    from q in query,
    select: %Conversation{id: q.id}
  end

  defp initial_query_tags([head | tail], query) do
    query = from c in query,
            join: ct in "conversations_tags", on: c.id == ct.conversation_id,
            where: ct.tag_id == ^head
    initial_query_tags(tail, query)
  end
end
