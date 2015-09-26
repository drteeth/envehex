defmodule Stuff do
  alias EnvEh.Weather
  alias EnvEh.Forecast
  alias EnvEh.Warning
  alias EnvEh.Repo

  def parse(feed) do
    groups = feed.entries |> Enum.group_by fn e ->
      e.category
    end

    # Repo.insert(Weather, )
    {
      parse_current(List.first(groups['Current Conditions'])),
      Enum.reject(groups['Warnings and Watches'], &is_null_warning?/1),
      Enum.map(groups['Weather Forecasts'], &to_forecast/1),
    }
  end

  defp parse_current(entry) do
    {:ok, published_on} = entry.published |> to_string |> Ecto.DateTime.cast
    [_, conditions, temp] = to_string(entry.title)
    |> String.split([":", "/", ","], trim: true)
    |> Enum.map(&String.strip/1)
    %Weather{
      source_id: entry.id,
      published_on: published_on,
      summary: conditions,
      temperature: temp
    }
  end

  defp is_null_warning?(entry) do
    entry.summary == 'No watches or warnings in effect.' \
    && entry.title == 'No watches or warnings in effect, Toronto'
  end

  defp to_forecast(entry) do
    title = entry.title
    summary = entry.summary
    {:ok, published_on} = entry.published |> to_string |> Ecto.DateTime.cast

    [day, quick_summary | rest] = String.split(to_string(title), [":", "."], trim: true)

    forecast = %Forecast{
      source_id: entry.id,
      published_on: published_on,
      summary: summary,
      quick_summary: String.strip(quick_summary),
      day: day,
    }

    parse_forecast(rest, forecast)
  end

  defp parse_forecast([], forecast), do: forecast
  defp parse_forecast([head|tail], forecast) do
    chunk = String.strip(head)
    new_forecast = cond do
      Regex.match?(~r/High+/, chunk) -> %{ forecast | high: chunk }
      Regex.match?(~r/Low+/,  chunk) -> %{ forecast | low:  chunk }
      Regex.match?(~r/POP+/,  chunk) -> %{ forecast | pop:  chunk }
      true -> forecast
    end

    parse_forecast(tail, new_forecast)
  end

end
