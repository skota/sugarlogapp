defmodule SugarlogappWeb.LoginWebController do
    import Plug.Conn
    
    use SugarlogappWeb, :controller 
    alias Sugarlogapp.Data   
    alias Sugarlogapp.Data.User   
    alias  Sugarlogapp.Guardian
    

    # add reference to repo....repo will contains changesets and references to user model
    plug :put_layout, "login.html"    
    
    def new(conn, _params) do        
        render(conn, "new.html")
    end

    def create(conn, %{"login" => login_params}) do
        # render conn, "create.html"
        case Data.find_and_confirm_password(login_params) do
            {:ok, user} ->
                #get and store user settings in conn
                # user_settings = Data.get_setting!(user.id)
                username = user.first_name <> " "<> user.last_name

                conn
                |> put_session(:setting, %{ current_user: user})
                |> Guardian.Plug.sign_in(user)
                |> redirect(to: "/readings")
            :error ->
                conn
                |> put_flash(:error, "Invalid username/password")
                |> redirect(to: "/login")
            :not_activated ->    
                conn
                |> put_flash(:error, "Account not activated or does not exist.")
                |> redirect(to: "/login")
        end
    end

    def logout(conn, _) do
        conn
        |> Guardian.Plug.sign_out
        |> put_flash(:info, "Logged out")
        |> redirect(to: "/login")
    end

    def password_changed(conn, _) do
        conn
        |> Guardian.Plug.sign_out
        |> render("password-changed.html")

    end
end