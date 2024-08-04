defmodule BowBuilderApp.Repo.Migrations.AddReferenceFromOptionTypeToComponent do
  use Ecto.Migration

  def change do
    alter table(:option_types) do
      add :component_id, references(:components, on_delete: :delete_all)
    end

    create index(:option_types, [:component_id])
  end

end
