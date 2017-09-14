defmodule IntercomStats.Intercom.AdapterTest do
  use IntercomStatsWeb.ConnCase

  alias IntercomStats.Intercom.Adapter

  test "process url gives the right url" do
    full_url = "https://api.intercom.io/tags"
    assert full_url == Adapter.process_url("/tags")
  end
end
