defmodule EnvEh.Repo.Migrations.CreateWeather do
  use Ecto.Migration

  def change do
    create table(:weather) do
      add :temperature, :float
      add :summary, :string

      timestamps
    end

  end
end
