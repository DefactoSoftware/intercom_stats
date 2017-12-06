defmodule IntercomStats.Intercom.Conversation do
  use Ecto.Schema
  import Ecto.Changeset
  alias IntercomStats.Intercom.{Tag, Conversation}

  @primary_key {:id, :string, []}
  schema "conversations" do
    many_to_many :tags, Tag, join_through: "conversations_tags"
    field :time_to_first_response, :integer
    field :closing_time, :integer
    field :total_response_time, :integer
    field :average_response_time, :integer
    field :company_name, :string

    field :open_timestamp, :integer
    field :closed_timestamp, :integer
  end

  @doc false
  def changeset(%Conversation{} = conversation, attrs) do
    conversation
    |> cast(attrs, [
      :id,
      :time_to_first_response,
      :closing_time,
      :average_response_time,
      :company_name,
      :total_response_time,
      :closed_timestamp,
      :open_timestamp
    ])
  end
end
