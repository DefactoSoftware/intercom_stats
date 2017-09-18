defmodule IntercomStats.Repo.Migrations.CreateSegments do
  use Ecto.Migration

  def change do
    create table(:segments, primary_key: false) do
      add :id, :string, primary_key: true
      add :name, :string
      add :person_type, :string

      timestamps()
    end
  end
end
