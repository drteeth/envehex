defmodule EnvEh.WeatherController do
  use EnvEh.Web, :controller

  def index(conn, _params) do
    render conn, stuff: %{hi: "there"}
  end

end
