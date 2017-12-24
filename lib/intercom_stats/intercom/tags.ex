defmodule IntercomStats.Intercom.Tags do
  alias IntercomStats.Intercom.API
  alias IntercomStats.Repo
  alias IntercomStats.Intercom.Tag

  def save_from_api do
    {:ok, %{body: body}} = API.get("/tags")

    body
    |> API.decode_json
    |> save_tag_list
  end

  defp save_tag_list(%{"tags" => tag_list}) do
    tag_list
    |> Enum.map(
      fn(%{"name" => name, "id" => id}) ->
        insert_or_update_tag(id, %{name: name})
      end
    )
  end

  defp insert_or_update_tag(id, changes) do
    result = case Repo.get(Tag, id) do
               nil -> %Tag{id: id}
               tag -> tag
             end

    result
    |> Tag.changeset(changes)
    |> Repo.insert_or_update
  end
end
