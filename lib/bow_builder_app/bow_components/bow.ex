defmodule BowBuilderApp.BowComponents.Bow do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bows" do
    field :name, :string
    field :user_id, :id
    has_many :bow_components, BowBuilderApp.BowComponents.BowComponent

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bow, attrs) do
    bow
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
