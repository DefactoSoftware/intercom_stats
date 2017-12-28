defmodule IntercomStatsWeb.Context do
  @moduledoc """
  """

  @behaviour Plug
  import Plug.Conn
  alias IntercomStats.Coherence.User

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})
      {:error, reason} ->
        put_private(conn, :absinthe, %{context: %{current_user: nil}})
    end
  end

  @doc """
  Return the current user context based on the authorization header
  """
  defp build_context(conn) do
    case Coherence.current_user(conn) do
      %User{} = current_user -> {:ok, %{current_user: current_user}}
      nil -> {:error, "You are not logged in"}
    end
  end
end
