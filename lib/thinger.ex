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

  def foo_it(feed) do
    warning_entry, current_entry = Enum.group_by(collection)(feed.entries, 2)
    forecast_entries = Enum.drop(feed.entries, 2)

    |> Enum.map fn e -> end
    %Weather{

    }
  end

end
