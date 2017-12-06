defmodule IntercomStatsWeb.Resolvers.Conversation do
  alias IntercomStats.Repository.Conversations

  def get_conversations(_, _, _) do
    {:ok, Conversations.list_all_conversations}
  end
end
