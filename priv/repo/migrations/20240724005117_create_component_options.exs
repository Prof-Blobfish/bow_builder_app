defmodule BowBuilderApp.Repo.Migrations.CreateComponentOptions do
  use Ecto.Migration

  def change do
    create table(:component_options) do
      add :name, :string
      add :value, :string
      add :component_id, references(:components, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:component_options, [:component_id])
  end
end
