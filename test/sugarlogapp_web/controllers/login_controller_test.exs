defmodule SugarlogappWeb.LoginControllerTest do
    use SugarlogappWeb.ConnCase
    # import Timex.Time
    # alias Sugarlogapp.Repo
    alias Sugarlogapp.Data
    # alias Sugarlogapp.Data.User

    setup do
        Data.create_user(%{ first_name: "sriram",last_name: "kota",
                    email: "sri@mail.com",password: "Password!23"})    
        {:ok, conn: put_req_header(conn, "accept", "application/json")}            
    end    

    test "Login with email and password logs in user and return JWT", %{conn: conn} do
        params = %{ email: "sri@mail.com", password: "Password!23" }
        
        conn =  conn
                |> post("/api/login", %{"login" => params})
    
        assert json_response(conn, 200)
        assert conn.assigns.jwt != nil
       
    end

    test "login should fail with incorrect username and password", %{conn: conn} do
        params = %{ email: "sri@mail.com", password: "Password!2gfgf3" }
        
        conn =  conn
                |> post("/api/login", %{"login" => params})
    
        assert json_response(conn, 401)
        assert conn.assigns.message == "Could not login. Invalid username or password"       
    end
end    