defmodule EnvEh.Repo.Migrations.CreateForecast do
  use Ecto.Migration

  def change do
    create table(:forecasts) do
      add :high, :float
      add :low, :float
      add :pop, :float
      add :summary, :string
      add :quick_summary, :string
      add :day, :date
      add :published_at, :datetime

      timestamps
    end

  end
end
