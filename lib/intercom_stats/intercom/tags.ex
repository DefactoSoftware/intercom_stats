defmodule IntercomStats.Intercom.Tags do
  alias IntercomStats.Intercom.API
  alias IntercomStats.Repo
  alias IntercomStats.Intercom.Tag

  def save_from_api do
    {:ok, %{body: body}} = API.get("/tags")
    tags =
      body
      |> API.decode_json
      |> convert_to_tag_list

    Repo.insert_all(Tag, tags)
  end

  defp convert_to_tag_list(%{"tags" => tag_list}) do
    tag_list
    |> Enum.map(fn(%{"name" => name}) -> %{name: name} end)
  end
end
