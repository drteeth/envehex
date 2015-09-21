defmodule EnvEh.WeatherTest do
  use EnvEh.ModelCase

  alias EnvEh.Weather

  @valid_attrs %{summary: "some content", temperature: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Weather.changeset(%Weather{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Weather.changeset(%Weather{}, @invalid_attrs)
    refute changeset.valid?
  end
end
