defmodule IntercomStatsWeb.PageControllerTest do
  use IntercomStatsWeb.ConnCase
  import IntercomStats.Factory

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
    setup do
      conn = login(conn)
      insert :conversation_support

      {:ok, conn: conn}
    end

    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ "Conversation data"
    end

    test "GET /get_from_api", %{conn: conn} do
      insert :intercom_conversation
      conn = get(conn, "/get_from_api")
      assert html_response(conn, 200) =~ "Conversation data"
    end
  end
end
