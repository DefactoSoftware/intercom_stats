defmodule IntercomStats.Intercom.TagsTest do
  use IntercomStatsWeb.ConnCase

  alias IntercomStats.Intercom.Tag
  alias IntercomStats.Repo
  alias IntercomStats.Intercom.Tags

  test "save intercom tags" do
    Tags.save_from_api

    assert Enum.count(Repo.all(Tag)) == 2
  end

  test "only unique tags are saved" do
    Tags.save_from_api
    Tags.save_from_api

    assert Enum.count(Repo.all(Tag)) == 2
  end
end
