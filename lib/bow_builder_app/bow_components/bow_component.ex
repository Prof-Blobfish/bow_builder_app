defmodule BowBuilderApp.BowComponents.BowComponent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bow_components" do
    field :option_values, :map
    field :type, :string
    field :bow_id, :integer
    #field :component_id, :integer
    belongs_to :component, BowBuilderApp.BowComponents.Component
    # belongs_to :bow, BowBuilderApp.BowComponents.Bow

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bow_component, attrs) do
    bow_component
    |> cast(attrs, [:option_values, :component_id, :bow_id, :type])
    |> validate_required([:component_id, :bow_id, :type])
  end
end
