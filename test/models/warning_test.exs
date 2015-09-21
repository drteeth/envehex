defmodule EnvEh.WarningTest do
  use EnvEh.ModelCase

  alias EnvEh.Warning

  @valid_attrs %{link: "some content", published_at: "2010-04-17 14:00:00", text: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Warning.changeset(%Warning{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Warning.changeset(%Warning{}, @invalid_attrs)
    refute changeset.valid?
  end
end
