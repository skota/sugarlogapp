defmodule SugarlogappWeb.Api.RegisterController do
    use SugarlogappWeb, :controller    

    alias SugarlogappWeb.Data


    def create(conn, %{"user" => user_params}) do
        #create use from params

        case Data.User.create() do            
            {:ok, user} ->
                # ok..next user must verify email
                conn
                |> put_status(:created)      
                |> render("user.json", user: user)
            {:error, changeset} ->
                #error tell user why use creation failed..
                IO.puts inspect changeset
                render conn, "registration-error.json", changeset: changeset                
        end    

    end

    def activate() do 
    end    


end
