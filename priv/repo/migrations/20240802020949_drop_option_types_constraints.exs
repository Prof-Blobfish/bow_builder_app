defmodule BowBuilderApp.Repo.Migrations.DropOptionTypesConstraints do
  use Ecto.Migration

  def change do
    alter table(:option_values) do
      remove :option_type_id
    end
  end
end
