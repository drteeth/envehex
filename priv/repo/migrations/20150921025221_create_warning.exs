defmodule EnvEh.Repo.Migrations.CreateWarning do
  use Ecto.Migration

  def change do
    create table(:warnings) do
      add :text, :string
      add :link, :string
      add :published_at, :datetime

      timestamps
    end

  end
end
