defmodule BowBuilderApp.BowComponents.Component do
  use Ecto.Schema
  import Ecto.Changeset

  schema "components" do
    field :name, :string
    field :type, :string
    field :price, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(component, attrs) do
    component
    |> cast(attrs, [:type, :name, :price])
    |> validate_required([:type, :name, :price])
  end
end
