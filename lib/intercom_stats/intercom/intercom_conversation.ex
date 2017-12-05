defmodule IntercomStats.Intercom.IntercomConversation do
  use Ecto.Schema
  import Ecto.Changeset
  alias IntercomStats.Intercom.IntercomConversation

  schema "intercom_conversations" do
    field :last_update, :naive_datetime
  end

  @doc false
  def changeset(%IntercomConversation{} = intercom_conversation, attrs) do
    intercom_conversation
    |> cast(attrs, [:last_update])
    |> validate_required([])
  end
end
