defmodule IntercomStatsWeb.Resolvers.Tag do
  @moduledoc """
  """

  alias IntercomStats.Repository.Tags

  def get_tags(_, arg, _) do
    {:ok, Tags.list_all_tags(arg)}
  end
end
