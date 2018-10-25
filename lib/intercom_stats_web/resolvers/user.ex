defmodule IntercomStatsWeb.Resolvers.User do
  @moduledoc """
  User resolver
  """

  alias IntercomStats.Coherence.User
  alias IntercomStats.Repo

  def find(%{id: id}, _info) do
    case Repo.get(User, id) do
      nil -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end

  def current(_, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def current(_, _) do
    {:error, "Access denied"}
  end
end
