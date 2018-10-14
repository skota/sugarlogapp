defmodule Sugarlogapp.Repo.Migrations.AddNotesToReading do
  use Ecto.Migration

  def change do
    alter table(:readings) do
      add :notes, :text, null: true
    end

  end
end
