defmodule IntercomStats.Repository.Segments do
  alias IntercomStats.Intercom.Segment
  alias IntercomStats.Repo

  def list_conversations_by_segments([head | tail], conversations \\ []) do
    case tail do
      [] ->
        segment = Repo.get_by(Segment, name: head)
        returned_conversations = Repo.all Ecto.assoc(segment, :conversations)
        conversations = conversations ++ returned_conversations
      _  ->
        segment = Repo.get_by(Segment, name: head)
        returned_conversations = Repo.all Ecto.assoc(segment, :conversations)
        conversations = conversations ++ returned_conversations
        list_conversations_by_segments(tail, conversations)
    end
  end
end
