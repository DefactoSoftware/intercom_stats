defmodule IntercomStatsWeb.Context do
  @moduledoc """
  A plug to add current user to the context.
  """

  @behaviour Plug
  import Plug.Conn
  alias IntercomStats.Coherence.User

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})

      {:error, _} ->
        put_private(conn, :absinthe, %{context: %{current_user: nil}})
    end
  end

  defp build_context(conn) do
    case Coherence.current_user(conn) do
      %User{} = current_user -> {:ok, %{current_user: current_user}}
      nil -> {:error, "You are not logged in"}
    end
  end
end
