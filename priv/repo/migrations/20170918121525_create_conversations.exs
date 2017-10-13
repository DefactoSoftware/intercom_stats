defmodule IntercomStats.Repo.Migrations.CreateConversations do
  use Ecto.Migration

  def change do
    create table(:conversations) do
      add :time_to_first_response, :integer
      add :closing_time, :integer
      add :total_response_time, :integer
      add :average_response_time, :integer
      add :segment_id, references(:segments, type: :string)

      add :open_timestamp, :timestamp
      add :closed_timestamp, :timestamp

      timestamps()
    end
  end
end
