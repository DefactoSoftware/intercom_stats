defmodule IntercomStatsWeb.ConversationsControllerTest do
  use IntercomStatsWeb.ConnCase
  import IntercomStats.Factory
  import IntercomStatsWeb.Gettext

  setup do
    conn = build_conn()
           |> login()

    {:ok, conn: conn}
  end

  test "Render first_response page", %{conn: conn} do
    insert :conversation, time_to_first_response: 30
    conn = get(conn, "/conversations/first_response")
    assert html_response(conn, 200) =~ gettext("Gemiddelde eerste reactietijd")
  end

  test "Render closing_time page", %{conn: conn} do
    insert :conversation, closing_time: 120
    conn = get(conn, "/conversations/closing_time")
    assert html_response(conn, 200) =~ gettext("Gemiddelde sluittijd")
  end
end
