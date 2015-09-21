defmodule EnvEh.Router do
  use EnvEh.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EnvEh do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", EnvEh do
    pipe_through :api

    get "/weather", WeatherController, :index
    get "/weather/:id", WeatherController, :show

    resources "/forecasts", ForecastController, except: [:new, :edit]
    resources "/warnings", WarningController, except: [:new, :edit]
  end
end
