defmodule SugarlogappWeb.RegistrationControllerTest do
    use SugarlogappWeb.ConnCase
    import Timex.Time

    describe "create user" do
        test "Creates, and responds with a newly created user if attributes are valid", %{conn: conn} do
            params = %{
                first_name: "sriram",
                last_name: "kota",
                email: "sri@mail.com",
                password: "Password!23"
            }
        
            conn =  conn
                    |> post("/api/register", %{"register" => params})
        
            assert response(conn, 201)
        end
        
        test "should  not create user if attributes are valid", %{conn: conn} do
            params = %{
                first_name: "sriram",
                last_name: "kota",
                email: "sri@mail.com",
                password: "Password3"
            }
        
            conn =  conn
                    |> post("/api/register", %{"register" => params})
            
            assert response(conn, 401)
            # need to check for actual error message
        end
    end

    # describe "activate user" do
    #     test "should activate with valid activation_token" do
    #         activation_token_created_dt = Timex.to_datetime({{2018,8,6}, {15,48,0}}, "Etc/UTC") 
            
    #         params = %{
    #             email: "sri@mail.com",
    #             activation_token: "abc1234",
    #             activation_token_created_at: "sri@mail.com",
    #         }
        
    #         conn =  conn
    #                 |> put("/api/activate/:token", %{"register" => params})
        
    #         assert response(conn, 201)
        
    #     end
    # end    
  end
  