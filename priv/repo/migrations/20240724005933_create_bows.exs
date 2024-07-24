defmodule BowBuilderApp.Repo.Migrations.CreateBows do
  use Ecto.Migration

  def change do
    create table(:bows) do
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:bows, [:user_id])
  end
end
