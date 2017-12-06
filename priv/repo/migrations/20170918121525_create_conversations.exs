defmodule IntercomStats.Repo.Migrations.CreateConversations do
  use Ecto.Migration

  def change do
    create table(:conversations, primary_key: false) do
      add :id, :string, primary_key: true
      add :time_to_first_response, :integer
      add :closing_time, :integer
      add :total_response_time, :integer
      add :average_response_time, :integer
      add :company_name, :string

      add :closed_timestamp, :integer
      add :open_timestamp, :integer
    end
  end
end
