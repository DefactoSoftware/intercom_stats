defmodule IntercomStatsWeb.Schema do
  use Absinthe.Schema

  import Ecto.Query

  alias IntercomStatsWeb.Resolvers

  query do
    field :tags, list_of(:tag) do
      resolve authorize(&Resolvers.Tag.get_tags/3)
    end

    @desc "Get an App User by ID"
    field :user, type: :user do
      arg :id, non_null(:id)
      resolve authorize(&Resolvers.User.find/2)
    end

    @desc "Get current App User"
    field :current_user, type: :user do
      resolve authorize(&Resolvers.User.current/2)
    end
  end

@desc "Tags for converations"
  object :tag do
    field :id, :string
    field :name, :string
  end

  @desc "A user"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
  end

  # Authorization
  def authorize(fun) do
    fn (source, args, %{context: %{current_user: user} = info}) ->
      case user do
        nil -> {:error, :unauthorized}
        _ -> Absinthe.Resolution.call(fun, source, args, info)
      end
    end
  end
end
