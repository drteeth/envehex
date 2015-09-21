defmodule EnvEh.WeatherView do
  use EnvEh.Web, :view

  def render("index.json", %{weather: weather}) do
    %{data: render_many(weather, EnvEh.WeatherView, "weather.json")}
  end

  def render("show.json", %{weather: weather}) do
    %{data: render_one(weather, EnvEh.WeatherView, "weather.json")}
  end

  def render("weather.json", %{weather: weather}) do
    %{id: weather.id,
      temperature: weather.temperature,
      summary: weather.summary}
  end
end
