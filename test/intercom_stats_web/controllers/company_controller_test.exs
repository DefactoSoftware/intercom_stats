defmodule IntercomStatsWeb.CompanyControllerTest do
  use IntercomStatsWeb.ConnCase
  import IntercomStats.Factory

  setup do
    conn =
      build_conn()
      |> login()

    {:ok, conn: conn}
  end

  test "GET /", %{conn: conn} do
    company_name = "Company"
    insert_list(3, :conversation_support, company_name: company_name)
    conn = get(conn, "/company/#{company_name}")
    assert html_response(conn, 200) =~ company_name
  end
end
