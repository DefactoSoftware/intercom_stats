defmodule IntercomStats.Repo.Migrations.CreateSegments do
  use Ecto.Migration

  def change do
    create table(:segments) do
      add :name, :string
    end
  end
end
