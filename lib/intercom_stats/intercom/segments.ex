defmodule IntercomStats.Intercom.Segments do
  alias IntercomStats.Intercom.API
  alias IntercomStats.Repo
  alias IntercomStats.Intercom.Segment

  def save_from_api do
    {:ok, %{body: body}} = API.get("/segments")

    segments =
      body
      |> API.decode_json
      |> convert_to_segment_list

    Repo.insert_all(Segment, segments)
  end

  defp convert_to_segment_list(%{"segments" => segment_list}) do
    segment_list
    |> Enum.map(fn(%{"name" => name}) -> %{name: name} end)
  end
end
