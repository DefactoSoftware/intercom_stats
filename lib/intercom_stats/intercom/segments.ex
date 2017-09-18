defmodule IntercomStats.Intercom.Segments do
  alias IntercomStats.Intercom.API
  alias IntercomStats.Repo
  alias IntercomStats.Intercom.Segment

  def save_from_api do
    {:ok, %{body: body}} = API.get("/segments")

    body
    |> API.decode_json
    |> save_segment_list
  end

  defp save_segment_list(%{"segments" => segment_list}) do
    segment_list
    |> Enum.map(
      fn(%{"id" => id, "name" => name, "person_type" => person_type}) ->
        save_or_update_segment(id, %{name: name, person_type: person_type})
      end
    )
  end

  defp save_or_update_segment(id, changes) do
    case Repo.get(Segment, id) do
      nil -> %Segment{id: id}
      segment -> segment
    end
    |> Segment.changeset(changes)
    |> Repo.insert_or_update
  end
end
