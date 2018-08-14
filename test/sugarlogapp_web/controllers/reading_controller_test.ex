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



        # test "Should return users data if jwt is present and is valid" do
        #     jwt = "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJzdWdhcmxvZ2FwcCIsImV4cCI6MTUzNjY5MjcwNSwiaWF0IjoxNTM0MjczNTA1LCJpc3MiOiJzdWdhcmxvZ2FwcCIsImp0aSI6IjM1MzE3NmNjLTM3MTYtNGViOC05ODllLWE1NDc2YjU2NWYxMyIsIm5iZiI6MTUzNDI3MzUwNCwic3ViIjoiMiIsInR5cCI6ImFjY2VzcyJ9.VuyTAZjziMDX5nxwUi0BtSnUKbd5VkUY15ytjyS5gsa-SzdmETJoI09Bzjg-eB97oakdWxl67l4aHRwvf8FhQA"
        #     resp =  conn
        #             |> put_req_header("authorization", jwt)
        #             |> get("/api/readings")

        #     # assert response has error message and status code 401 
        #     assert resp.status == 200
        #     assert resp.resp_body == "secret page..!"
        # end
        
        test "Should return unauthorized if jwt is invalid" do
            jwt = "Bearer abc123"
            resp =  conn
                    |> put_req_header("authorization", jwt)
                    |> get("/api/readings")

            # assert response has error message and status code 401 
            assert resp.status == 401
            assert resp.resp_body == "invalid_token"
        end

        test "should create new readings and return 201 if valid jwt is present" do
        end    
    end    
end    