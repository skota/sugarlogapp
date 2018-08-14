defmodule SugarlogappWeb.Router do
  use SugarlogappWeb, :router

  pipeline :auth do
    plug Sugarlogapp.Auth.Pipeline
  end
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    # plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  end

  # we dont have any browser routes..only api
  scope "/", SugarlogappWeb do
    pipe_through :browser # Use the default browser stack
  end

  # Other scopes may use custom stacks.
  scope "/api", SugarlogappWeb do
    pipe_through :api

    # registration and activate
    post "/register", RegistrationController, :create  
    put "/activate/:token", RegistrationController, :activate  

    #login
    post "/login", LoginController, :create  

    
    #forgot password
    # get "/changepassword", LoginController, :password_changed  
    #reset password
    # get "/resetpassword", PasswordController, :new  
    # post "/resetpassword", PasswordController, :create  
  end

  # protected routes
  scope "/api", SugarlogappWeb do
    pipe_through [:api, :auth, :ensure_auth]

    #readings
    resources "/readings", ReadingController

  end  
  
  # catch all route
  # get "/*path", NorouteController, :index
end
