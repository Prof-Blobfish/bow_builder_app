defmodule BowBuilderApp.Repo.Migrations.AddTypeToBowComponent do
  use Ecto.Migration

  def change do
    alter table(:bow_components) do
      add :type, :string
    end
  end
end
