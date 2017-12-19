defmodule IntercomStatsWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common datastructures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  alias IntercomStats.Coherence.User
  alias IntercomStats.Repo

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import IntercomStatsWeb.Router.Helpers

      # The default endpoint for testing
      @endpoint IntercomStatsWeb.Endpoint

      @user_attrs %{name: "some name", email: "some@email.com", "password": "secret", "password_confirmation": "secret"}
      def login(conn) do
        create_user()
        post(conn, session_path(conn, :create), %{session: @user_attrs})
      end

      defp create_user do
        user = User.changeset(%User{}, @user_attrs)
               |> Repo.insert!
        {:ok, user: user}
      end
    end
  end


  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(IntercomStats.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(IntercomStats.Repo, {:shared, self()})
    end
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
