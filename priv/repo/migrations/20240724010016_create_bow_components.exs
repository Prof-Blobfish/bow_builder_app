defmodule BowBuilderApp.Repo.Migrations.CreateBowComponents do
  use Ecto.Migration

  def change do
    create table(:bow_components) do
      add :option_values, :map
      add :bow_id, references(:bows, on_delete: :nothing)
      add :component_id, references(:components, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:bow_components, [:bow_id])
    create index(:bow_components, [:component_id])
  end
end
