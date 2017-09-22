defmodule IntercomStats.Intercom.IntercomConversation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "intercom_conversation" do
    field :intercom_id, :string
    field :created_at, :naive_datetime
    field :updated_at, :naive_datetime


  end
end
