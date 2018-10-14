defmodule SugarlogappWeb.NorouteController do
    use SugarlogappWeb, :controller
    plug :put_layout, "dashboard.html" 

    def index(conn,_params) do
        #  render conn, "404.html"    
        # for 404 just redirect to dashboard  
        # redirect(conn, to: "/")
        render conn, "404.html"    
    end
end
  