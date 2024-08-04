defmodule BowBuilderApp.Repo.Migrations.DropOptionTypes do
  use Ecto.Migration

  def change do
    drop table(:option_types)
  end
end
