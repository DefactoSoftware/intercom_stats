defmodule IntercomStats.Intercom.Conversation do
  use Ecto.Schema
  import Ecto.Changeset
  alias IntercomStats.Intercom.Conversation


  schema "conversations" do

    timestamps()
  end

  @doc false
  def changeset(%Conversation{} = conversation, attrs) do
    conversation
    |> cast(attrs, [])
    |> validate_required([])
  end
end
