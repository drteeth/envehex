defmodule EnvEh.Forecast do
  use EnvEh.Web, :model

  schema "forecasts" do
    field :high, :float
    field :low, :float
    field :pop, :float
    field :summary, :string
    field :quick_summary, :string
    field :day, Ecto.Date
    field :published_at, Ecto.DateTime

    timestamps
  end

  @required_fields ~w(high low pop summary quick_summary day published_at)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
