defmodule IntercomStats.Intercom.Segments do

  alias IntercomStats.Intercom.ApiCalls
  alias IntercomStats.Repo
  alias IntercomStats.Intercom.Segment

  def save_segments() do
    data_list = request_segments_from_api()
    |> ApiCalls.decode_json
    |> convert_to_segment_list

    Repo.insert_all(Segment, data_list)
  end

  defp request_segments_from_api() do
    "[{
        \"type\": \"segment\",
        \"id\": \"53203e244cba153d39000062\",
        \"name\": \"New\",
        \"created_at\": 1394621988,
        \"updated_at\": 1394622004
        },
        {
        \"type\": \"segment\",
        \"id\": \"53203e244cba153d39000054\",
        \"name\": \"New2\",
        \"created_at\": 1394621990,
        \"updated_at\": 1394622008
        }]"
  end

  defp convert_to_segment_list(decoded_json) do
    list = decoded_json
    |> Enum.map(fn(%{"name" => name}) ->  %{name: name} end)
  end
end
