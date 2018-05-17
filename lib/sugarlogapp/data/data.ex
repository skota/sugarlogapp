defmodule SugarlogappWeb.Data do

    import Ecto.Query, warn: false
    import Timex.Ecto.DateTime
    
    alias SugarlogappWeb.Data.User
    # need password validator
    
    
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