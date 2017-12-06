defmodule IntercomStats.Factory do
  use ExMachina.Ecto, repo: IntercomStats.Repo
  use IntercomStats.{
    ConversationFactory,
    TagFactory,
    IntercomConversationFactory
  }
end
