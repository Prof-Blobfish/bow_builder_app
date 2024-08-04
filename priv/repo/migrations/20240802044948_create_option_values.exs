defmodule BowBuilderApp.Repo.Migrations.CreateOptionValues do
  use Ecto.Migration

  def change do
    create table(:option_values) do
      add :name, :string
      add :option_type_id, references(:option_types, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:option_values, [:option_type_id])
  end
end
