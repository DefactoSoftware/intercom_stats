defmodule IntercomStats.Repository.Tags do
  alias IntercomStats.Intercom.Tag
  alias IntercomStats.Repo

  def list_conversations_by_tags([head | tail], conversations \\ []) do
    case tail do
      [] ->
        tag = Repo.get_by(Tag, name: head)
        returned_conversations = Repo.all Ecto.assoc(tag, :conversations)
        conversations = conversations ++ returned_conversations
        Enum.uniq(conversations)
      _  ->
        tag = Repo.get_by(Tag, name: head)
        returned_conversations = Repo.all Ecto.assoc(tag, :conversations)
        conversations = conversations ++ returned_conversations
        list_conversations_by_tags(tail, conversations)
    end
  end

end
