defmodule IntercomStatsWeb.Resolvers.Tag do
  alias IntercomStats.Repository.Tags

  def get_tags(_, _, _) do
    {:ok, Tags.list_all_tags}
  end
end
