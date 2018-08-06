defmodule Sugarlogapp.Data do

    import Ecto.Query, warn: false
    import Timex.Ecto.DateTime
    
    # alias the schema
    alias Sugarlogapp.Data.User
    alias Sugarlogapp.Repo
    
    
    
    def build_user(attrs \\ %{}) do
        %User{}
        |> User.blank_changeset(attrs)
    end    

    def create_user(attrs \\ %{}) do
        %User{}
        |> User.changeset(attrs)
        |> Repo.insert()
    end


    
end    