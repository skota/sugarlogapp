defmodule Sugarlogapp.Repo.Migrations.Readings do
  use Ecto.Migration

  def change do
    add :user_id, :integer, null: false
    add :reading, :ineteger, null: false
    add :time_of_day, :string, null: false
    add :reading_taken_dt, :utc_datetime, null: true
    timestamps()
  end
end
