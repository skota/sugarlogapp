defmodule SugarlogappWeb.ReadingControllerTest do
    use SugarlogappWeb.ConnCase

    describe "readings scenarios" do
        test "Should return unauthorized if header does not contain jwt" do
            resp =  conn
                    |> get("/api/readings")

            # assert response has error message and status code 401 
            assert resp.status == 401
            assert resp.resp_body == "unauthenticated"
        end    

        test "Should return unauthorized if jwt is invalid" do
            jwt = "Bearer abc123"
            resp =  conn
                    |> put_req_header("authorization", jwt)
                    |> get("/api/readings")

            # assert response has error message and status code 401 
            assert resp.status == 401
            assert resp.resp_body == "invalid_token"
        end

        # test "should create new readings and return 201 if valid jwt is present" do
        #     # should successfully login first an
        #     params = %{ email: "sri@mail.com", password: "Password!23" }
        
        #     conn =  conn
        #             |> post("/api/login", %{"login" => params})
        
        #     assert json_response(conn, 200)
        #     assert conn.assigns.jwt != nil
        #     # get token
        #     # jwt = "Bearer "<> assert conn.assigns.jwt

        #     # now create 
        #     # resp =  conn
        #     #         |> put_req_header("authorization", jwt)
        #     #         |> get("/api/readings")

        #     # # assert response has error message and status code 401 
        #     # assert resp.status == 401
        # end    
    end    
end    