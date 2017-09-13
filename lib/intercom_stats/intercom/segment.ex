defmodule IntercomStats.Intercom.Segment do
  use Ecto.Schema
  import Ecto.Changeset
  alias IntercomStats.Intercom.Segment


  schema "segments" do

    timestamps()
  end

  @doc false
  def changeset(%Segment{} = segment, attrs) do
    segment
    |> cast(attrs, [])
    |> validate_required([])
  end
end
