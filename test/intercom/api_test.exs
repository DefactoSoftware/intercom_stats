defmodule IntercomStats.Intercom.APITest do
  use IntercomStatsWeb.ConnCase

  alias IntercomStats.Intercom.API

  @json_response """
  {
    "tags": [{
      "id": "17513",
      "name": "independent",
      "type": "tag"
      },
      {
      "id": "17523",
      "name": "independent2",
      "type": "tag"
    }]
  }
  """

  test "get information from the api" do
    {:ok, %{body: body}} = API.get("/tags")
    assert body == @json_response
  end

  test "decode good json" do
    assert API.decode_json(@json_response) == %{
      "tags" => [%{
        "id" => "17513",
        "name" => "independent",
        "type"=> "tag"
        },
        %{
        "id" => "17523",
        "name" => "independent2",
        "type" => "tag"
      }]
    }
  end

  test "decode wrong json" do
    assert API.decode_json("tag") == "Something went wrong decoding the json"
  end
end
