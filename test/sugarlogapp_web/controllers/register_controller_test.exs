defmodule SugarlogappWeb.RegisterControllerTest do
    use SugarlogappWeb.ConnCase

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

        # test "Returns an error and does not create a user if attributes are invalid"
        test "should  not create user if attributes are valid", %{conn: conn} do
            params = %{
                first_name: "sriram",
                last_name: "kota",
                email: "sri@mail.com",
                password: "Password3"
            }
        
            conn =  conn
                    |> post("/api/register", %{"register" => params})
            
            %{"errors" => errors} = json_response(conn, 200)
            
            # TODO need to pattern match and confirm we error for invalid password
            # assert Enum.any?(errors, fn error -> error["attribute"] == "password" end)        
            # assert %{password: ["Invalid Password. Must be atleast 8 chars long. Must contain 1 or more capital letter, 1 number and 1 special character."]} = errors_on(changeset)                        # 
            
        end

    end
  end
  