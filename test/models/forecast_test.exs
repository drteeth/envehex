defmodule EnvEh.ForecastTest do
  use EnvEh.ModelCase

  alias EnvEh.Forecast

  @valid_attrs %{day: "2010-04-17", high: "120.5", low: "120.5", pop: "120.5", published_at: "2010-04-17 14:00:00", quick_summary: "some content", summary: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Forecast.changeset(%Forecast{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Forecast.changeset(%Forecast{}, @invalid_attrs)
    refute changeset.valid?
  end
end
