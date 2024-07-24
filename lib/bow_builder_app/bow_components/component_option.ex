defmodule BowBuilderApp.BowComponents.ComponentOption do
  use Ecto.Schema
  import Ecto.Changeset

  schema "component_options" do
    field :name, :string
    field :value, :string
    field :component_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(component_option, attrs) do
    component_option
    |> cast(attrs, [:name, :value])
    |> validate_required([:name, :value])
  end
end
