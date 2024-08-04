defmodule BowBuilderApp.Repo.Migrations.DropOptionValues do
  use Ecto.Migration

  def change do
    drop table(:option_values)
  end
end
