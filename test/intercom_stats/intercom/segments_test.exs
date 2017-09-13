defmodule IntercomStats.Intercom.SegmentsTest do
  use IntercomStatsWeb.ConnCase

  alias IntercomStats.Intercom.Segments
  alias IntercomStats.Intercom.Segment
  alias IntercomStats.Repo
  alias IntercomStats.Intercom.ApiCalls

  @segment_json "[{
      \"type\": \"segment\",
      \"id\": \"53203e244cba153d39000062\",
      \"name\": \"New\",
      \"created_at\": 1394621988,
      \"updated_at\": 1394622004
      },
      {
      \"type\": \"segment\",
      \"id\": \"53203e244cba153d39000054\",
      \"name\": \"New2\",
      \"created_at\": 1394621990,
      \"updated_at\": 1394622008
      }]"

  test "decode segments json into appropriate format" do
    assert ApiCalls.decode_json(@segment_json) == [%{
      "type" => "segment",
      "id" => "53203e244cba153d39000062",
      "name" => "New",
      "created_at" => 1394621988,
      "updated_at" => 1394622004
      },
      %{
      "type" => "segment",
      "id" => "53203e244cba153d39000054",
      "name" => "New2",
      "created_at" => 1394621990,
      "updated_at" => 1394622008
      }]
  end

  test "decoded json correctly saved in database" do
    Segments.save_segments()

    Repo.all(Segment) == [%Segment{id: 1, name: "New"}, %Segment{id: 2, name: "New2"}]
  end
end
