defmodule BowBuilderApp.Repo.Migrations.DropOptionValuesAgain do
  use Ecto.Migration

  def change do
    drop table(:option_values)
  end
end
