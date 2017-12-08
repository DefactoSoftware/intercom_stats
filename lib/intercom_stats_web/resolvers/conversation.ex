defmodule IntercomStatsWeb.Resolvers.Conversation do
  alias IntercomStats.Repository.Conversations

  def get_conversations(_, arg, _) do
    {:ok, Conversations.list_all_conversations(arg)}
  end
end
