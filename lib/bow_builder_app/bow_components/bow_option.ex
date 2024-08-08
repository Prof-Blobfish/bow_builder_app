defmodule BowBuilderApp.BowComponents.BowOption do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bow_options" do
    belongs_to :bow_component, BowBuilderApp.BowComponents.BowComponent
    belongs_to :option_type, BowBuilderApp.BowComponents.OptionType
    belongs_to :option_value, BowBuilderApp.BowComponents.OptionValue

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bow_option, attrs) do
    bow_option
    |> cast(attrs, [:option_type_id, :option_value_id])
    |> validate_required([:option_type_id, :option_value_id])
  end
end
