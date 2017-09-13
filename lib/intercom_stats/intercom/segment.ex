defmodule IntercomStats.Intercom.Segment do
  use Ecto.Schema
  import Ecto.Changeset
  alias IntercomStats.Intercom.Segment
  alias IntercomStats.Intercom.Conversation

  schema "segments" do
    field :name, :string
    has_many :conversations, Conversation
  end

  @doc false
  def changeset(%Segment{} = segment, attrs) do
    segment
    |> cast(attrs, [:name])
    |> validate_required([])
  end
end
