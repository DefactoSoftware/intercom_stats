defmodule IntercomStats.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do

      timestamps()
    end

  end
end
