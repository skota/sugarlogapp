defmodule Sugarlogapp.Data do

    import Ecto.Query, warn: false

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
    
    # def activate_user(attrs \\ %{}) do
    #     %User{}
    #     |> User.activate_changeset(attrs)
    #     |> Repo.update()
    # end

    # TODO: 1. find user by id
    def get_user(id), do: Repo.get(User, id)
    
    #find user by email
    # TODO: should check for a/c with matching email and actviated=true
    def get_user_by_email(email), do: Repo.get_by(User, email: email)


    # TODO: 3. find user by activation token
    # TODO: 4. find user by reset token
    # find user by email and confirm that password matches
    def find_and_confirm_password(%{"email" => email, "password" => pass}) do        

        user = get_user_by_email(email)
        IO.puts inspect user
        if user do
            cond do
                user && Comeonin.Bcrypt.checkpw(pass, user.password_hash) ->
                    {:ok, user}
            true ->
                :error
            end
        else
            :not_activated
        end        
    end

    # --- readings ----------------------------
    #  blank changeset for creating a reading
    def build_reading(attrs \\ %{}) do
        %Reading{}
        |> Reading.blank_changeset(attrs)
    end    
    
    # create reading
    def create_reading(attrs \\ %{}) do
        %Reading{}
        |> Reading.changeset(attrs)
        |> Repo.insert()
    end

    def get_readings(user_id) do
        Reading 
        |> Ecto.Query.where(user_id: ^user_id) 
        |> Repo.all
    end

    # get reading
    def get_reading!(id, user_id) do
        Reading        
        |> Repo.get_by(id: id, user_id: user_id)
    end    

    # delete readings    
    def delete_reading!(reading) do
        Repo.delete(reading)
    end

    # update reading
    def update_reading!(reading) do
        Repo.update(reading)
    end

    def update_reading!(%Reading{} = reading, attrs) do
        reading
        |> Reading.update_changeset(attrs)
        |> Repo.update()
    end


end    