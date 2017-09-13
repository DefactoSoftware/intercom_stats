defmodule IntercomStats.Intercom.Conversation do
  use Ecto.Schema
  import Ecto.Changeset
  alias IntercomStats.Intercom.Conversation
  alias IntercomStats.Intercom.Segment
  alias IntercomStats.Intercom.Tag

  schema "conversations" do
    belongs_to :segments, Segment
    has_many :tags, Tag

    timestamps()
  end

  @doc false
  def changeset(%Conversation{} = conversation, attrs) do
    conversation
    |> cast(attrs, [])
    |> validate_required([])
  end
end
