defmodule SugarlogappWeb.HomeController do
    use SugarlogappWeb, :controller    
  
    plug :put_layout, "dashboard.html"
  
    def action(conn, _) do
        settings=get_session(conn, :setting)
        args = [conn, conn.params,  settings.current_user_name]
        apply(__MODULE__, action_name(conn), args)
    end

    def index(conn, _params, current_user_name) do
        render conn, "index.html", current_user_name: current_user_name
    end
  end
  