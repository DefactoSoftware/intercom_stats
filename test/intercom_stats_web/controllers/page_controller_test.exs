defmodule IntercomStatsWeb.PageControllerTest do
  use IntercomStatsWeb.ConnCase

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
end
