defmodule IntercomStats.SegmentsTest do
  use IntercomStatsWeb.ConnCase

  alias IntercomStats.Repo
  alias IntercomStats.Intercom.Segments
  alias IntercomStats.Intercom.Segment

  test "save intercom segments" do
    Segments.save_from_api

    assert Enum.count(Repo.all(Segment)) == 2
  end

  test "only unique segments are saved" do
    Segments.save_from_api
    Segments.save_from_api

    assert Enum.count(Repo.all(Segment)) == 2
  end
end
