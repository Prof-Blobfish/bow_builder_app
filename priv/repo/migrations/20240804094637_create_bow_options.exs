defmodule BowBuilderApp.Repo.Migrations.CreateBowOptions do
  use Ecto.Migration

  def change do
    create table(:bow_options) do
      add :bow_component_id, references(:bow_components, on_delete: :delete_all)
      add :option_value_id, references(:option_values, on_delete: :delete_all)
      add :option_type_id, references(:option_types, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:bow_options, [:bow_component_id])
    create index(:bow_options, [:option_value_id])
    create index(:bow_options, [:option_type_id])
  end
end
