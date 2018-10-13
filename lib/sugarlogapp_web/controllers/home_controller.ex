defmodule SugarlogappWeb.HomeController do
    use SugarlogappWeb, :controller    
  
    plug :put_layout, "dashboard.html"
  
    def index(conn, _params) do
        # get the min, max and average of readings
        


        render conn, "index.html"
    end
  end
  