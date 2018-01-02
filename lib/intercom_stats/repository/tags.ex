defmodule IntercomStats.Repository.Tags do
  @moduledoc """
  Module containing fucntions to retrieve persisted tags from the database
  """

  import Ecto.Query

  alias IntercomStats.Intercom.Tag
  alias IntercomStats.Repo

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
