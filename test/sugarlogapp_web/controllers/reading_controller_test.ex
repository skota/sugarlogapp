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

        # test "should create new readings and return 201 if valid jwt is present",%{conn: conn} do
        #     # get token
        #     jwt = "Bearer "<> assert login_conn.assigns.jwt

        #     # now create 
        #     readings_resp =  conn
        #             |> put_req_header("authorization", jwt)
        #             |> get("/api/readings")

        #     # # assert response has error message and status code 401 
        #     assert readings_resp.status == 200
        # end    
    end    
end    