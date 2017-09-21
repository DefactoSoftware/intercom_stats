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
            where: s.name in ^segments_list,
            select: %Conversation{id: c.id}
    Repo.all(query)
  end

  def list_conversations_by_tags(:or, tags_list) do
    query = from t in "tags",
            join: ct in "conversations_tags", on: t.id == ct.tag_id,
            join: c in "conversations", on: ct.conversation_id == c.id,
            where: t.name in ^tags_list,
            select: %Conversation{id: c.id}
    Repo.all(query)
    |> Enum.uniq_by(fn %{id: id} -> id end)
  end

  def list_conversations_by_tags(:and, tags_list) do

  end

  def list_conversations_by_segments_and_tags(:or, segments_list, tags_list) do
    seg_list = list_conversations_by_segments(segments_list)
    tag_list = list_conversations_by_tags(:or, tags_list)
    seg_list -- (seg_list -- tag_list)
  end

  def list_conversations_by_segments_and_tags(:and, segments_list, tags_list) do
    seg_list = list_conversations_by_segments(segments_list)
    tag_list = list_conversations_by_tags(:and, tags_list)
    seg_list -- (seg_list -- tag_list)
  end
end
