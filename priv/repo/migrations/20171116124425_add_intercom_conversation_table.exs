defmodule IntercomStats.Repo.Migrations.AddIntercomConversationTable do
  use Ecto.Migration

  def change do
    create table(:intercom_conversations) do
      add :last_update, :naive_datetime
    end
  end
end
