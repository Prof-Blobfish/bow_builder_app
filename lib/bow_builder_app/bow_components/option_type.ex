defmodule BowBuilderApp.BowComponents.OptionType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "option_type" do
    field :name, :string
    field :value, :string
    field :component_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(option_type, attrs) do
    option_type
    |> cast(attrs, [:name, :value])
    |> validate_required([:name, :value])
  end
end
