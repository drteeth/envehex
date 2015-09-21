defmodule EnvEh.WarningView do
  use EnvEh.Web, :view

  def render("index.json", %{warnings: warnings}) do
    %{data: render_many(warnings, EnvEh.WarningView, "warning.json")}
  end

  def render("show.json", %{warning: warning}) do
    %{data: render_one(warning, EnvEh.WarningView, "warning.json")}
  end

  def render("warning.json", %{warning: warning}) do
    %{id: warning.id,
      text: warning.text,
      link: warning.link,
      published_at: warning.published_at}
  end
end
