defmodule IntercomStats.Factory do
  use ExMachina.Ecto, repo: IntercomStats.Repo
  use IntercomStats.{
    SegmentFactory,
    ConversationFactory,
    TagFactory
  }
end
