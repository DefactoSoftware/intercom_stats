defmodule IntercomStats.Intercom.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias IntercomStats.Intercom.Tag


  schema "tags" do

    timestamps()
  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [])
    |> validate_required([])
  end
end
