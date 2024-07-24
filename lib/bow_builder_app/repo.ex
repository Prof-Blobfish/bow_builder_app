defmodule BowBuilderApp.Repo do
  use Ecto.Repo,
    otp_app: :bow_builder_app,
    adapter: Ecto.Adapters.Postgres
end
