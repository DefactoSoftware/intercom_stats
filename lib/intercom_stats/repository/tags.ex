defmodule IntercomStats.Repository.Tags do

  alias IntercomStats.Intercom.Tag
  alias IntercomStats.Repo
  import Ecto.Query

  def list_all_tags(%{name: name}) do
    name = "%#{name}%"
    Repo.all(from tag in Tag, where: like(tag.name, ^name))
  end

  def list_all_tags(%{}), do: list_all_tags
  def list_all_tags() do
    Repo.all(Tag)
  end
end
