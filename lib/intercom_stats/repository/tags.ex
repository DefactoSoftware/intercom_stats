defmodule IntercomStats.Repository.Tags do

  alias IntercomStats.Intercom.Tag
  alias IntercomStats.Repo
  import Ecto.Query

  def list_all_tags(%{name: name}) do
    Repo.all(from tag in Tag,
            where: tag.name == ^name,
            join: conversations in assoc(tag, :conversations),
            preload: [conversations: conversations])
  end

  def list_all_tags(%{}) do
    Repo.all(Tag)
  end
end
