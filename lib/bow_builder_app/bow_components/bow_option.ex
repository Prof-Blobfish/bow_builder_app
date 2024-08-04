defmodule BowBuilderApp.BowComponents.BowOption do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bow_options" do

    field :bow_component_id, :id
    field :option_value_id, :id
    field :option_type_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bow_option, attrs) do
    bow_option
    |> cast(attrs, [])
    |> validate_required([])
  end
end
