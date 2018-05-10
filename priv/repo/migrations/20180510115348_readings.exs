defmodule Sugarlogapp.Repo.Migrations.Readings do
  use Ecto.Migration

  def change do
    create table(:readings) do
      add :user_id, :integer, null: false
      add :reading, :integer, null: false
      add :time_of_day, :string, null: false
      add :reading_taken_dt, :utc_datetime, null: true
      timestamps()
    end  
  end
end
