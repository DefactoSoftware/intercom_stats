defmodule IntercomStats.Intercom.Tags do

  alias IntercomStats.Intercom.ApiCalls
  alias IntercomStats.Repo
  alias IntercomStats.Intercom.Tag

  def save_tags() do
    data_list = request_tags_from_api()
    |> ApiCalls.decode_json
    |> convert_to_tag_list

    Repo.insert_all(Tag, data_list)
  end

  defp request_tags_from_api() do
    "[{
      \"id\": \"17513\",
      \"name\": \"independent\",
      \"type\": \"tag\"
      },
      {
      \"id\": \"17523\",
      \"name\": \"independent2\",
      \"type\": \"tag\"
    }]"
  end

  defp convert_to_tag_list(decoded_json) do
    list = decoded_json
    |> Enum.map(fn(%{"name" => name}) ->  %{name: name} end)
  end
end
