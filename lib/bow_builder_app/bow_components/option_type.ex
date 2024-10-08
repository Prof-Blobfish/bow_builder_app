defmodule BowBuilderApp.BowComponents.OptionType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "option_types" do
    field :name, :string
    belongs_to :component, BowBuilderApp.BowComponents.Component
    has_many :option_values, BowBuilderApp.BowComponents.OptionValue, on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(option_type, attrs) do
    option_type
    |> cast(attrs, [:name, :component_id])
    |> validate_required([:name, :component_id])
  end
end
