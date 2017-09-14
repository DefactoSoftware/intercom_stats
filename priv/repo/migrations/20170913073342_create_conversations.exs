defmodule IntercomStats.Repo.Migrations.CreateConversations do
  use Ecto.Migration

  def change do
    create table(:conversations) do
      add :title, :string
      add :time_to_first_response, :integer
      add :total_response_time, :integer
      timestamps()
    end

  end
end
