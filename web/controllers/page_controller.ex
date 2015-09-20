defmodule EnvEh.PageController do
  use EnvEh.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
