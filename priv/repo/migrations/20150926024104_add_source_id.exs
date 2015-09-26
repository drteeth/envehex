defmodule EnvEh.Repo.Migrations.AddSourceId do
  use Ecto.Migration

  def change do
    alter table(:weather) do
      add :source_id, :string, null: false
    end
    alter table(:forecasts) do
      add :source_id, :string, null: false
    end
    alter table(:warnings) do
      add :source_id, :string, null: false
    end
  end
end
