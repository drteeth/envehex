json.warnings @weather.warnings, :link, :text

json.current @weather.current, :temperature, :conditions

json.forecasts @weather.forecasts, :title
