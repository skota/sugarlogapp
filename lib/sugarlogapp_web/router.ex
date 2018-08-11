defmodule SugarlogappWeb.Router do
  use SugarlogappWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SugarlogappWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    # login
    # activate
    # forgot password
    # reset password

    # readings  ( crud)
  end

  # Other scopes may use custom stacks.
  scope "/api", SugarlogappWeb do
    pipe_through :api

    get "/hello", LoginController, :hello  
    post "/register", RegisterController, :create  

    #register/signup
    # post "/register", RegisterController, :create  

    #actviate

    #login
    # post "/login", LoginController, :create  
    # post "/logout", LogoutController, :logout  


    #forgot password
    # get "/changepassword", LoginController, :password_changed  

    #reset password
    # get "/resetpassword", PasswordController, :new  
    # post "/resetpassword", PasswordController, :create  

  end
  
  # catch all route
  # get "/*path", NorouteController, :index
end
