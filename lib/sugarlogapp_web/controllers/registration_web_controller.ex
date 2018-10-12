defmodule SugarlogappWeb.RegistrationWebController do
    use SugarlogappWeb, :controller
    alias Sugarlogapp.Data
    alias Sugarlogapp.Data.User
    alias Sugarlogapp.Email
    alias Sugarlogapp.Mailer

    
    plug :put_layout, "login.html"    

    def new(conn, _) do        
        changeset = Data.build_user()        
        render(conn, "new.html", changeset: changeset)
    end

    defp build_email(conn,token,email) do        
        base_url = conn.host
        port = conn.port

        #only add port if it is not 80 or 443        
        reset_url = "http://"<>base_url <> ":"<>Integer.to_string(port)<> "/activate/" <> token 
        
        # user_details = %{ rest_url: reset_url, user_email: email}
        # Email.welcome_email(reset_url, email ) |> Mailer.deliver_later
        
        conn
        |> put_flash(:info, "Please verify your email.")
        |> render("activation-sent.html")

    end

    def create(conn, %{"register" => register_params}) do
        # generate activation token
        token = 40
        |> :crypto.strong_rand_bytes
        |> Base.url_encode64
        |> binary_part(0, 40)

        #token created at datetime
        token_created_at = Timex.now()

        params = Map.put(register_params, "activation_token",token)
                |> Map.put("activation_token_created_at",token_created_at)

        IO.puts inspect params

        case Data.create_user(params) do
            {:ok, user} ->
                # ok..next user must verify email
                conn
                |> build_email(token,user.email)

             {:error, changeset} ->
                IO.puts inspect changeset
                render conn, "new.html", changeset: changeset                
        end
    end

    # def activate(conn, %{"token" => token}) do
    #     IO.puts token

    #     case Ostomy.get_user_by_activation_token(token) do
    #         nil ->
    #             conn
    #             |> put_flash(:error, "This token is invalid")
    #             |> render("not-found.html")    
    #         user ->  
    #             #token found ..now activate account
    #             case Ostomy.activate_user(user, %{activated_at: true}) do
    #                 nil ->
    #                     conn
    #                     |> put_flash(:error, "This token is invalid")
    #                     |> render("not-found.html")    
    #                 user ->
    #                     conn
    #                     |> put_flash(:info, "Account activated successfully")
    #                     |> redirect(to: "/login")
    #             end    
    #     end    
    # end    
end
