defmodule SugarlogappWeb.LoginView do
  use SugarlogappWeb, :view

  def render("hello.json", %{}) do        
    %{message: "hello"}
  end

  def render("login.json", %{userid: id, jwt: token, exp: exp}) do        
    %{userid: id, jwt: token, exp: exp}
end


  def render("error.json", %{message: message}) do        
    %{message: message}
  end
end
  