defmodule IntercomStatsWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Ecto, repo: IntercomStats.Repo

  import Ecto.Query

  alias IntercomStatsWeb.Resolvers

  query do
    @desc "Get all tags"
    field :tags, list_of(:tag) do
      arg :name, :string
      resolve authorize(&Resolvers.Tag.get_tags/3)
    end

    @desc "Get all conversations"
    field :conversations, list_of(:conversation) do
      arg :filter, :conversation_filter
      resolve authorize(&Resolvers.Conversation.get_conversations/3)
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
    field :conversations, list_of(:conversation) do
      arg :filter, :conversation_filter
      resolve assoc(:conversations, fn conversation_query, %{filter: %{company_name: company_name}}, _context ->
        company_name = "%#{company_name}%"
        conversation_query
        |> where([c], like(c.company_name, ^company_name))
      end)
    end
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

  # Filter objects
  input_object :conversation_filter do
    field :company_name, :string
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
