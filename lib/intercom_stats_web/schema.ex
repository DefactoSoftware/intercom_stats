defmodule IntercomStatsWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Ecto, repo: IntercomStats.Repo
  import Ecto.Query

  alias Absinthe.Resolution
  alias IntercomStatsWeb.Resolvers
  alias Resolvers.{Conversation, Tag, User}

  query do
    @desc "Get all tags"
    field :tags, list_of(:tag) do
      arg :name, :string
      resolve authorize(&Tag.get_tags/3)
    end

    @desc "Get all conversations"
    field :conversations, list_of(:conversation) do
      arg :company_name, :string
      resolve authorize(&Conversation.get_conversations/3)
    end

    @desc "Get an App User by ID"
    field :user, type: :user do
      arg :id, non_null(:id)
      resolve authorize(&User.find/2)
    end

    @desc "Get current App User"
    field :current_user, type: :user do
      resolve authorize(&User.current/2)
    end
  end

  @desc "Tags for converations"
  object :tag do
    field :id, :string
    field :name, :string
    field :conversations, list_of(:conversation), resolve: assoc(:conversations)
  end

  @desc "Conversation data"
  object :conversation do
    field :id, :string
    field :time_to_first_response, :integer
    field :closing_time, :integer
    field :total_response_time, :integer
    field :average_response_time, :integer
    field :company_name, :string
    field :tags, list_of(:tag), resolve: assoc(:tags)
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
        _ -> Resolution.call(fun, source, args, info)
      end
    end
  end
end
