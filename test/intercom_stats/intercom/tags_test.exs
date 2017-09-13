defmodule IntercomStats.Intercom.TagsTest do
  use IntercomStatsWeb.ConnCase

  alias IntercomStats.Intercom.Tags
  alias IntercomStats.Intercom.Tag
  alias IntercomStats.Repo
  alias IntercomStats.Intercom.ApiCalls

  import Mock

  @tag_json "[{
    \"id\": \"17513\",
    \"name\": \"independent\",
    \"type\": \"tag\"
    },
    {
    \"id\": \"17523\",
    \"name\": \"independent2\",
    \"type\": \"tag\"
  }]"

  test "decode tag json into appropriate format" do
    assert ApiCalls.decode_json(@tag_json) == [%{
      "id" => "17513",
      "name" => "independent",
      "type" => "tag"},
      %{
        "id" => "17523",
        "name" => "independent2",
        "type" => "tag"
      }]
  end

  test "decoded json correctly saved in database" do
    Tags.save_tags()

    Repo.all(Tag) == [%Tag{id: 1, name: "independent"}, %Tag{id: 2, name: "independent2"}]
  end
end
