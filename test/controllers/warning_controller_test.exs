defmodule EnvEh.WarningControllerTest do
  use EnvEh.ConnCase

  alias EnvEh.Warning
  @valid_attrs %{link: "some content", published_at: "2010-04-17 14:00:00", text: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, warning_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    warning = Repo.insert! %Warning{}
    conn = get conn, warning_path(conn, :show, warning)
    assert json_response(conn, 200)["data"] == %{"id" => warning.id,
      "text" => warning.text,
      "link" => warning.link,
      "published_at" => warning.published_at}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, warning_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, warning_path(conn, :create), warning: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Warning, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, warning_path(conn, :create), warning: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    warning = Repo.insert! %Warning{}
    conn = put conn, warning_path(conn, :update, warning), warning: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Warning, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    warning = Repo.insert! %Warning{}
    conn = put conn, warning_path(conn, :update, warning), warning: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    warning = Repo.insert! %Warning{}
    conn = delete conn, warning_path(conn, :delete, warning)
    assert response(conn, 204)
    refute Repo.get(Warning, warning.id)
  end
end
