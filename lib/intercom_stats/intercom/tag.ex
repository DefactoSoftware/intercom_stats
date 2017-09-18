defmodule IntercomStats.Intercom.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias IntercomStats.Intercom.Tag
  alias IntercomStats.Intercom.Conversation

  @primary_key {:id, :string, []}
  schema "tags" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([])
  end
end
