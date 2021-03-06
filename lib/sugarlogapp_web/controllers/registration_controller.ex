defmodule SugarlogappWeb.RegistrationController do
    use SugarlogappWeb, :controller
    alias Sugarlogapp.Data
    alias Sugarlogapp.Data.User

    defp build_email(conn,token,email) do        
      base_url = conn.host
      port = conn.port

      #only add port if it is not 80 or 443        
      activation_url = "http://"<>base_url <> ":"<>Integer.to_string(port)<> "/activate/" <> token 
      
      # user_details = %{ rest_url: reset_url, user_email: email}
      Email.welcome_email(activation_url, email ) |> Mailer.deliver_later
      
      conn
      |> put_status(201)
      |> render("activation-sent.json", message: "Success! Your account has been created, You must activate your account before you can log in. Please check your email for activation instructions.")

    end
  
    def create(conn, %{"register" => user_params}) do
      token = 40
        |> :crypto.strong_rand_bytes
        |> Base.url_encode64
        |> binary_part(0, 40)

        #token created at datetime
        token_created_at = Timex.now()

        params = user_params 
                |> Map.put("activation_token",token)
                |> Map.put("activation_token_created_at",token_created_at)    

        # TODO move token generation and mail sending to a background job...
        # register should only be concerned with registering a user.. 

        case Data.create_user(params) do
            {:ok, user} ->
                # ok..next user must verify email
                # conn
                # |> build_email(token,user.email)
                
                conn
                |> put_status(201)
                |> render("activation-sent.json", 
                            message: "Success! Your account has been created, You must activate your account before you can log in. Please check your email for activation instructions.",
                            user: user.id)

            {:error, changeset} ->
                #error tell user why use creation failed..
                # IO.puts inspect changeset
                conn
                |> put_status(401)
                |> render("registration-error.json", changeset: changeset)
        end
    end 

    # def activate() do
        
    # end
  end
  