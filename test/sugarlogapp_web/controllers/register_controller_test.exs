defmodule SugarlogappWeb.RegisterControllerTest do
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
                    |> post("/api/activate:token", %{"register" => params})
            
            %{"errors" => errors} = json_response(conn, 200)
            
            # TODO need to pattern match and confirm we error for invalid password
            # assert Enum.any?(errors, fn error -> error["attribute"] == "password" end)        
            # assert %{password: ["Invalid Password. Must be atleast 8 chars long. Must contain 1 or more capital letter, 1 number and 1 special character."]} = errors_on(changeset)                        # 
            
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
  