defmodule IntercomStatsWeb.Schema do
  use Absinthe.Schema

  import Ecto.Query

  alias IntercomStatsWeb.Resolvers

  query do
    field :tags, list_of(:tag) do
      resolve &Resolvers.Tags.get_tags/3
    end
  end

  object :tag do
    field :id, :string
    field :name, :string
  end
end
