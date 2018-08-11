defmodule Sugarlogapp.Data do

    import Ecto.Query, warn: false
    import Timex.Ecto.DateTime
    
    # alias the schema-----------------------
    alias Sugarlogapp.Data.User
    alias Sugarlogapp.Data.Reading
    alias Sugarlogapp.Repo
    
    # --- users ------------------------------
    def build_user(attrs \\ %{}) do
        %User{}
        |> User.blank_changeset(attrs)
    end    

    def create_user(attrs \\ %{}) do
        %User{}
        |> User.changeset(attrs)
        |> Repo.insert()
    end
    
    def activate_user(attrs \\ %{}) do
        %User{}
        |> User.activate_changeset(attrs)
        |> Repo.update()
    end

    # TODO: 1. find user by id
    # TODO: 2. find user by email
    # TODO: 3. find user by activation token
    # TODO: 4. find user by reset token
    # TODO: 5. find user by email and confirm that password matches




    # --- readings ----------------------------
    #  blank changeset for creating a reading
    def build_reading(attrs \\ %{}) do
        %Reading{}
        |> Reading.blank_changeset(attrs)
    end    

    def create_reading(attrs \\ %{}) do
        %Reading{}
        |> Reading.changeset(attrs)
        |> Repo.insert()
    end

    # create reading


    # get readings

    # update readings

    # delete readings

    
end    