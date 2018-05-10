defmodule Sugarlogapp.Repo.Migrations.User do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :email, :string, null: false
      add :deleted_at, :utc_datetime, null: true
      add :remember_token, :string, null: true
      add :date_of_birth, :naive_datetime, null: true
      add :role, :string, size: 1, null: false
      add :active, :boolean, default: false
      add :password_hash, :string, null: false
      add :activation_token, :string,  null: true
      add :activation_token_created_at, :utc_datetime, null: true
      add :password_reset_token, :string, null: true
      add :password_reset_token_created_at, :utc_datetime, null: true
      timestamps()
    end  
  end
end
