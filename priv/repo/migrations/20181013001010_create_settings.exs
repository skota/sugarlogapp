defmodule Sugarlogapp.Repo.Migrations.CreateSettings do
  use Ecto.Migration

  def change do
    create table(:settings) do
      add :user_id, :integer, null: false
      add :timezone, :string
      add :notifications, :boolean
      add :reading_unit, :string
      timestamps()
    end  
  end
end
