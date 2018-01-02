defmodule IntercomStatsWeb.PageControllerTest do
  use IntercomStatsWeb.ConnCase
  import IntercomStatsWeb.Gettext
  import IntercomStats.Factory

  describe "Route to pages when not logged in" do
    test "GET /", %{conn: conn} do
      conn = get conn, "/"
      assert html_response(conn, 302)
    end
  end

  describe "Route to pages when logged in" do
    setup do
      conn = build_conn()
             |> login()

      {:ok, conn: conn}
    end

    test "GET /", %{conn: conn} do
      insert :conversation_support
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ gettext("Intercom gegevens")
    end

    test "GET / without conversations", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ gettext("Er zijn geen gesprekken")
    end
  end
end
