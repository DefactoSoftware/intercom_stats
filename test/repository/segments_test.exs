defmodule IntercomStats.RetrieveData.SegmentsTest do
  use IntercomStats.DataCase
  import IntercomStats.Factory

  alias IntercomStats.Repository.Segments

  test "list_conversations_by_segment/2 returns conversations filtered on segments" do
    segment1 = insert(:segment, name: "Defacto")
    segment2 = insert(:segment, name: "Radboud")
    insert(:conversation, segment: segment1)
    insert(:conversation, segment: segment1)
    insert(:conversation, segment: segment2)

    result_segment = Segments.list_conversations_by_segments(["Defacto"])
    result_segments = Segments.list_conversations_by_segments(["Defacto", "Radboud"])
    assert Enum.count(result_segment) == 2
    assert Enum.count(result_segments) == 3
  end
end
