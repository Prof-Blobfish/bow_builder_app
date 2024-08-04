defmodule BowBuilderApp.Repo.Migrations.CreateOptionTypes do
  use Ecto.Migration

  def change do
    create table(:option_types) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
