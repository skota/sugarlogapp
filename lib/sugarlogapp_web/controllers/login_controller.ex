defmodule SugarlogappWeb.LoginController do
    import Plug.Conn
    use SugarlogappWeb, :controller    
    
    def hello(conn, _params) do
        conn
        |> put_status(200)
        |> render("hello.json")             
    end     
end