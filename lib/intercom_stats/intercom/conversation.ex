defmodule IntercomStats.Intercom.Conversation do
  use Ecto.Schema
  import Ecto.Changeset
  alias IntercomStats.Intercom.Conversation
  alias IntercomStats.Intercom.Segment
  alias IntercomStats.Intercom.Tag

  @primary_key {:id, :string, []}
  schema "conversations" do
    belongs_to :segment, Segment
    many_to_many :tags, Tag, join_through: "conversations_tags"
    field :time_to_first_response, :integer
    field :closing_time, :integer
    field :total_response_time, :integer
    field :average_response_time, :integer

    timestamps()
  end

  @doc false
  def changeset(%Conversation{} = conversation, attrs) do
    conversation
    |> cast(attrs, [:title, :time_to_first_response, :total_response_time])
    |> validate_required([])
  end
end
