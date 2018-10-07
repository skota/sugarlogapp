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
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
    # plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  end
  
  # browser routes
  scope "/", PanelbulmaWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # api routes
  scope "/", SugarlogappWeb do
    pipe_through :browser # Use the default browser stack
  end

  # Other scopes may use custom stacks.
  scope "/api", SugarlogappWeb do
    pipe_through :api

    # registration and activate
    options "/register", RegistrationController, :options
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
    
    # reading_path  GET     /api/readings/:id/edit  SugarlogappWeb.ReadingController :edit
    # reading_path  GET     /api/readings/:id       SugarlogappWeb.ReadingController :show
    # reading_path  POST    /api/readings           SugarlogappWeb.ReadingController :create
  end  
  
  # catch all route
  # get "/*path", NorouteController, :index
end
