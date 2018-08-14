defmodule SugarlogappWeb.ReadingController do    
    use SugarlogappWeb, :controller 
    
    alias Sugarlogapp.Auth
    alias Sugarlogapp.Data
    # alias Sugarlogapp.Data.User
    alias Sugarlogapp.Guardian
    
    def index(conn, _params) do
        # get current user id
        current_user = Guardian.Plug.current_resource(conn)
        readings = Data.get_readings(current_user.id)
        IO.puts inspect readings

        render(conn, "index.json", readings: readings)
    end 

end    