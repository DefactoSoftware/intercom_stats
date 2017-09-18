defmodule IntercomStats.Intercom.Segment do
  use Ecto.Schema
  import Ecto.Changeset
  alias IntercomStats.Intercom.Segment
  alias IntercomStats.Intercom.Conversation

  @primary_key{:id, :string, []}
  schema "segments" do
    field :name, :string
    field :person_type, :string
    has_many :conversations, Conversation

    timestamps()
  end

  @doc false
  def changeset(%Segment{} = segment, attrs) do
    segment
    |> cast(attrs, [:name])
    |> validate_required([])
  end
end
