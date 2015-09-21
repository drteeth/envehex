defmodule EnvEh.ForecastView do
  use EnvEh.Web, :view

  def render("index.json", %{forecasts: forecasts}) do
    %{data: render_many(forecasts, EnvEh.ForecastView, "forecast.json")}
  end

  def render("show.json", %{forecast: forecast}) do
    %{data: render_one(forecast, EnvEh.ForecastView, "forecast.json")}
  end

  def render("forecast.json", %{forecast: forecast}) do
    %{id: forecast.id,
      high: forecast.high,
      low: forecast.low,
      pop: forecast.pop,
      summary: forecast.summary,
      quick_summary: forecast.quick_summary,
      day: forecast.day,
      published_at: forecast.published_at}
  end
end
