defmodule IntercomStats.Intercom.IntercomConversation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :string, []}
  schema "intercom_conversation" do
    field :last_update, :naive_datetime
  end
end
