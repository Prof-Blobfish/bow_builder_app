defmodule BowBuilderApp.BowComponents.OptionValue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "option_values" do
    field :name, :string
    belongs_to :option_type, BowBuilderApp.BowComponents.OptionType

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(option_value, attrs) do
    option_value
    |> cast(attrs, [:name, :option_type_id])
    |> validate_required([:name, :option_type_id])
  end
end
