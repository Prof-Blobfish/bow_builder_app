defmodule BowBuilderApp.BowComponents.BowComponent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bow_components" do
    field :option_values, :map
    field :component_id, :id
    field :bow_id, :id
    # belongs_to :bow, BowBuilderApp.BowComponents.Bow

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bow_component, attrs) do
    bow_component
    |> cast(attrs, [:option_values])
    |> validate_required([])
  end
end
