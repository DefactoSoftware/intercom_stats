defmodule IntercomStatsWeb.PageControllerTest do
  use IntercomStatsWeb.ConnCase
  import IntercomStats.Factory

  alias IntercomStats.Coherence.User
  alias IntercomStats.Repo

  @user_attrs %{name: "some name", email: "some@email.com", "password": "secret", "password_confirmation": "secret"}

  describe "Route to pages when not logged in" do
    test "GET /", %{conn: conn} do
      conn = get conn, "/"
      assert html_response(conn, 302)
    end

    test "GET /get_from_api", %{conn: conn} do
      conn = get conn, "/get_from_api"
      assert html_response(conn, 302)
    end
  end

  describe "Route to pages when logged in" do
    setup [:create_user]

    test "GET /", %{conn: conn} do
      conn = conn
            |> post(session_path(conn, :create), %{session: @user_attrs})
            |> get("/")
      assert html_response(conn, 200) =~ "Conversation data"
    end

    test "GET /get_from_api", %{conn: conn} do
      insert :intercom_conversation
      conn = conn
            |> post(session_path(conn, :create), %{session: @user_attrs})
            |> get("/get_from_api")
      assert html_response(conn, 200) =~ "Conversation data"
    end
  end

  defp create_user(_) do
    user = User.changeset(%User{}, @user_attrs)
                  |> Repo.insert!
    {:ok, user: user}
  end
end
