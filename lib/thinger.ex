defmodule Thinger do

  defmodule Weather do
    defstruct(current: nil, warnings: [], forecasts: [])
  end

  defmodule Warning do
    defstruct(text: nil, link: nil)
  end

  defmodule Current do
    defstruct(temperature: nil, conditions: nil)
  end

  defmodule Forecast do
    defstruct(
      high: nil,
      low: nil,
      pop: nil,
      summary: nil,
      quick_summary: nil,
      day: nil,
    )
  end

  def foo_it(feed) do
    groups = feed.entries |> Enum.group_by fn e ->
      e.category
    end

    %Weather{
      current: parse_current(List.first(groups['Current Conditions'])),
      warnings: Enum.reject(groups['Warnings and Watches'], &is_null_warning?/1),
      forecasts: Enum.map(groups['Weather Forecasts'], &to_forecast/1),
    }
  end

  defp parse_current(entry) do
    [_, conditions, temp] = to_string(entry.title)
    |> String.split([":", "/", ","], trim: true)
    |> Enum.map(&String.strip/1)
    %Current{conditions: conditions, temperature: temp}
  end

  defp is_null_warning?(entry) do
    entry.summary == 'No watches or warnings in effect.' \
    && entry.title == 'No watches or warnings in effect, Toronto'
  end

  defp to_forecast(entry) do
    title = entry.title
    summary = entry.summary

    [day, quick_summary, rest] = String.split(to_string(title), [":", "."], trim: true)

    forecast = %Forecast{
      summary: summary,
      quick_summary: String.strip(quick_summary),
      day: day,
    }

    cond do
      Regex.match?(~r/High+/, rest) -> %{ forecast | high: String.strip(rest) }
      Regex.match?(~r/Low+/,  rest) -> %{ forecast | low:  String.strip(rest) }
      Regex.match?(~r/POP+/,  rest) -> %{ forecast | pop:  String.strip(rest) }
    end
  end

end
