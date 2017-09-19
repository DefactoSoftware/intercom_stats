defmodule IntercomStats.RetrieveData.TagsTest do
  use IntercomStats.DataCase
  import IntercomStats.Factory

  alias IntercomStats.Repository.Tags

  test "list_conversations_by_tags/2 returns conversations filtered on tags" do
    tag1 = insert(:tag, name: "prio1")
    tag2 = insert(:tag, name: "prio2")
    tag3 = insert(:tag, name: "bug")
    tag4 = insert(:tag, name: "assistance")
    insert(:conversation, tags: [tag1, tag3])
    insert(:conversation, tags: [tag1, tag4])
    insert(:conversation, tags: [tag2, tag3])

    result_tags = Tags.list_conversations_by_tags(["prio1", "bug"])

    assert Enum.count(result_tags) == 3
  end
end
