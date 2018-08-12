defmodule SugarlogappWeb.LoginControllerTest do
    use SugarlogappWeb.ConnCase
    import Timex.Time
    alias Sugarlogapp.Repo
    alias Sugarlogapp.Data
    alias Sugarlogapp.Data.User

    setup do
        Data.create_user(%{ first_name: "sriram",last_name: "kota",
                    email: "sri@mail.com",password: "Password!23"})    
        {:ok, conn: put_req_header(conn, "accept", "application/json")}            
    end    

    test "Login with email and password logs in user and return JWT", %{conn: conn} do
        # params = %{email: "sri@mail.com",password: "Password!23"}
        # person = insert(:person, auth_token: nil)
        # conn = post(conn, "/in", auth: %{email: person.email})
        # person = Repo.get(Person, person.id)
        # assert html_response(conn, 200) =~ "Check your email"
        # assert person.auth_token != nil
        # assert_delivered_email ChangelogWeb.Email.sign_in(person)

        # do a post to /api/login with params email and password
        # assert that the request was a 200 and
        # assert that a user and jwt are returned
        params = %{ email: "sri@mail.com", password: "Password!23" }
        
        conn =  conn
                |> post("/api/login", %{"login" => params})
    
        assert json_response(conn, 200)
    end

    # login should fail with incorrect username and password
end    