defmodule Sugarlogapp.Data do

    import Ecto.Query, warn: false
    import Timex.Ecto.DateTime
    
    # alias the schema
    alias Sugarlogapp.Data.User
    alias Sugarlogapp.Data.Reading
    alias Sugarlogapp.Repo
    
    
    # --- users
    def build_user(attrs \\ %{}) do
        %User{}
        |> User.blank_changeset(attrs)
    end    

    def create_user(attrs \\ %{}) do
        %User{}
        |> User.changeset(attrs)
        |> Repo.insert()
    end

    # --- readings
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