defmodule EnvEh.WeatherControllerTest do
  use EnvEh.ConnCase

  alias EnvEh.Weather
  @valid_attrs %{summary: "some content", temperature: "120.5"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, weather_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    weather = Repo.insert! %Weather{}
    conn = get conn, weather_path(conn, :show, weather)
    assert json_response(conn, 200)["data"] == %{"id" => weather.id,
      "temperature" => weather.temperature,
      "summary" => weather.summary}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, weather_path(conn, :show, -1)
    end
  end

end
