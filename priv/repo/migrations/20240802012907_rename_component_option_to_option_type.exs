defmodule BowBuilderApp.Repo.Migrations.RenameComponentOptionToOptionType do
  use Ecto.Migration

  def change do
    rename table(:component_options), to: table(:option_types)
  end
end
