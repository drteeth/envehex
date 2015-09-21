defmodule EnvEh.WarningController do
  use EnvEh.Web, :controller

  alias EnvEh.Warning

  plug :scrub_params, "warning" when action in [:create, :update]

  def index(conn, _params) do
    warnings = Repo.all(Warning)
    render(conn, "index.json", warnings: warnings)
  end

  def create(conn, %{"warning" => warning_params}) do
    changeset = Warning.changeset(%Warning{}, warning_params)

    case Repo.insert(changeset) do
      {:ok, warning} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", warning_path(conn, :show, warning))
        |> render("show.json", warning: warning)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EnvEh.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    warning = Repo.get!(Warning, id)
    render conn, "show.json", warning: warning
  end

  def update(conn, %{"id" => id, "warning" => warning_params}) do
    warning = Repo.get!(Warning, id)
    changeset = Warning.changeset(warning, warning_params)

    case Repo.update(changeset) do
      {:ok, warning} ->
        render(conn, "show.json", warning: warning)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EnvEh.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    warning = Repo.get!(Warning, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(warning)

    send_resp(conn, :no_content, "")
  end
end
