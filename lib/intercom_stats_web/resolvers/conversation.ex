defmodule IntercomStatsWeb.Resolvers.Conversation do
  @moduledoc """
  Conversation resolver
  """

  alias IntercomStats.Repository.Conversations

  def get_conversations(_, arg, _) do
    {:ok, Conversations.list_all_conversations(arg)}
  end
end
