defmodule IntercomStats.Repo.Migrations.AddJoinThroughTableConversationTag do
  use Ecto.Migration

  def change do
    create table(:conversations_tags, primary_key: false) do
      add :conversation_id, references(:conversations)
      add :tag_id, references(:tags, type: :string)
    end
  end
end
