defmodule Sugarlogapp.Auth.WebErrorHandler do
    import Plug.Conn
    import Phoenix.Controller

    def auth_error(conn, {type, _reason}, _opts) do
      body = to_string(type)
      
      conn
      |> put_flash(:error, "You need to sign in or sign up before continuing.")
      |> redirect(to: "/login")
    #   |> halt()
    end
  end