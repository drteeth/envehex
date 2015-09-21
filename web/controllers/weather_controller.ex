defmodule EnvEh.WeatherController do
  use EnvEh.Web, :controller

  alias EnvEh.Weather

  def index(conn, _params) do
    weather = Repo.all(Weather)
    render(conn, "index.json", weather: weather)
  end

  def show(conn, %{"id" => id}) do
    weather = Repo.get!(Weather, id)
    render conn, "show.json", weather: weather
  end

end
