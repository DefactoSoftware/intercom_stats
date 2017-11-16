defmodule IntercomStats.Intercom.IntercomConversation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :string, []}
  schema "intercom_conversation" do
    field :last_update, :naive_datetime
  end

  @doc false
  def changeset(%IntercomConversation{} = intercom_conversation, attrs) do
    intercom_conversation
    |> cast(attrs, [:id, :last_update])
    |> validate_required([])
  end
end
