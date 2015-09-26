defmodule EnvEh.Repo.Migrations.AddPublishedOn do
  use Ecto.Migration

  def change do
    alter table(:weather) do
      add :published_on, :datetime, null: false
    end
    alter table(:forecasts) do
      add :published_on, :datetime, null: false
    end
    alter table(:warnings) do
      add :published_on, :datetime, null: false
    end
  end
end
