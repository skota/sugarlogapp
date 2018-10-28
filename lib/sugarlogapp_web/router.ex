defmodule SugarlogappWeb.Router do
  use SugarlogappWeb, :router

  pipeline :auth do
    # we are passing error-handler here because we could be using different error handlers
    # for web and api
    plug Guardian.Plug.Pipeline, error_handler: Sugarlogapp.Auth.ErrorHandler
    plug Sugarlogapp.Auth.Pipeline
  end


  pipeline :browser_authenticate do
    plug Guardian.Plug.Pipeline, error_handler: Sugarlogapp.Auth.WebErrorHandler
    # plug Auth.Pipeline
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

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    # plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
    # plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  end
  
  # browser routes
  # scope "/", SugarlogappWeb do
  #   pipe_through :browser # Use the default browser stack

  #   get "/login", LoginWebController, :new  
  #   post "/login", LoginWebController, :create  
  #   get "/logout", LoginWebController, :logout  
    
  #   # reset password
  #   # get "/passchange", LoginController, :password_changed  
    
  #   get "/register", RegistrationWebController, :new  
  #   post "/register", RegistrationWebController, :create  
  # end

  # scope "/", SugarlogappWeb do
  #   pipe_through [:browser_authenticate, :browser, :browser_session]
    
  #   get "/", HomeController, :index  
    
  #   # endpoints for readings
  #   resources "/readings", ReadingWebController
    
  #   get "/settings", SettingsWebController, :index
  #   put "/setting/:id", SettingsWebController, :update
  #   # get "/*path", NorouteController, :index
  # end  

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
  
  
  scope "/", SugarlogappWeb do
    pipe_through(:browser)

    get("/*path", PageController, :index)
  end  
end
