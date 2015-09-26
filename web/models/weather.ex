defmodule EnvEh.Weather do
  use EnvEh.Web, :model

  schema "weather" do
    field :source_id, :string
    field :temperature, :float
    field :summary, :string
    field :published_on, Ecto.DateTime

    timestamps
  end

  @required_fields ~w(temperature summary)
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
