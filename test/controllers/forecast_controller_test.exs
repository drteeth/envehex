defmodule EnvEh.ForecastControllerTest do
  use EnvEh.ConnCase

  alias EnvEh.Forecast
  @valid_attrs %{day: "2010-04-17", high: "120.5", low: "120.5", pop: "120.5", published_at: "2010-04-17 14:00:00", quick_summary: "some content", summary: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, forecast_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    forecast = Repo.insert! %Forecast{}
    conn = get conn, forecast_path(conn, :show, forecast)
    assert json_response(conn, 200)["data"] == %{"id" => forecast.id,
      "high" => forecast.high,
      "low" => forecast.low,
      "pop" => forecast.pop,
      "summary" => forecast.summary,
      "quick_summary" => forecast.quick_summary,
      "day" => forecast.day,
      "published_at" => forecast.published_at}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, forecast_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, forecast_path(conn, :create), forecast: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Forecast, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, forecast_path(conn, :create), forecast: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    forecast = Repo.insert! %Forecast{}
    conn = put conn, forecast_path(conn, :update, forecast), forecast: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Forecast, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    forecast = Repo.insert! %Forecast{}
    conn = put conn, forecast_path(conn, :update, forecast), forecast: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    forecast = Repo.insert! %Forecast{}
    conn = delete conn, forecast_path(conn, :delete, forecast)
    assert response(conn, 204)
    refute Repo.get(Forecast, forecast.id)
  end
end
