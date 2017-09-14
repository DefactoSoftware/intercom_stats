defmodule IntercomStats.Intercom.Conversation do
  use Ecto.Schema
  import Ecto.Changeset
  alias IntercomStats.Intercom.Conversation
  alias IntercomStats.Intercom.Segment
  alias IntercomStats.Intercom.Tag

  schema "conversations" do
    belongs_to :segments, Segment
    has_many :tags, Tag
    field :title, :string
    field :time_to_first_response, :integer
    field :total_response_time, :integer
    timestamps()
  end

  @doc false
  def changeset(%Conversation{} = conversation, attrs) do
    conversation
    |> cast(attrs, [:title, :time_to_first_response, :total_response_time])
    |> validate_required([])
  end
end
