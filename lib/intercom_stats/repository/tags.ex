defmodule IntercomStats.Repository.Tags do

  alias IntercomStats.Intercom.Tag
  alias IntercomStats.Repo
  import Ecto.Query

  def list_all_tags() do
    Repo.all(Tag)
  end
end
