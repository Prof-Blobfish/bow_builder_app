defmodule BowBuilderApp.BowComponents.BowComponent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bow_components" do
    field :option_values, :map
    field :bow_id, :id
    field :component_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bow_component, attrs) do
    bow_component
    |> cast(attrs, [:option_values])
    |> validate_required([])
  end
end
