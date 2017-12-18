defmodule IntercomStatsWeb.Resolvers.Conversation do
  alias IntercomStats.Repository.Conversations

  def get_conversations(_, filter, _) do
    {:ok, Conversations.list_all_conversations(filter)}
  end
end
