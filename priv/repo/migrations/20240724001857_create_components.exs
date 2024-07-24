defmodule BowBuilderApp.Repo.Migrations.CreateComponents do
  use Ecto.Migration

  def change do
    create table(:components) do
      add :type, :string
      add :name, :string
      add :price, :float

      timestamps(type: :utc_datetime)
    end
  end
end
