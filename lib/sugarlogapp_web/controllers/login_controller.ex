defmodule SugarlogappWeb.LoginController do
    import Plug.Conn
    use SugarlogappWeb, :controller 
    alias Sugarlogapp.Data   
    alias  Sugarlogapp.Guardian
    
    def hello(conn, _params) do
        conn
        |> put_status(200)
        |> render("hello.json")             
    end     

    def create(conn, %{"login" => login_params}) do
        case Data.find_and_confirm_password(login_params) do
            {:ok, user} ->
                # new_conn = Guardian.Plug.sign_in(conn, user)
                # jwt = Guardian.Plug.current_token(new_conn)
                # {:ok, claims} = Guardian.Plug.claims(new_conn)
                # exp = Map.get(claims, "exp")
                {:ok, token, full_claims} = Guardian.encode_and_sign(user)
                exp = Map.get(full_claims, "exp")

                conn
                |> render( "login.json", userid: user.id, jwt: token, exp: exp)
            :error ->
                conn
                |> put_status(401)
                |> render("error.json", message: "Could not login")
        end
      end 
end