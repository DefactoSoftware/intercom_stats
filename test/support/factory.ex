defmodule IntercomStats.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: IntercomStats.Repo

  use IntercomStats.{
    ConversationFactory,
    TagFactory,
    IntercomConversationFactory
  }
end
