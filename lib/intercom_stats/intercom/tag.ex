defmodule IntercomStats.Intercom.Tag do
  @moduledoc """
  Schema representing an Intercom Tag
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias IntercomStats.Intercom.{Conversation, Tag}

  @primary_key {:id, :string, []}
  schema "tags" do
    field(:name, :string)
    many_to_many(:conversations, Conversation, join_through: "conversations_tags")

    timestamps()
  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([])
  end
end
