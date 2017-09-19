defmodule IntercomStats.Repository.Conversations do
  alias IntercomStats.Intercom.Conversation
  alias IntercomStats.Repo

  def list_all_conversations() do
    Repo.all(Conversation)
  end
end
