defmodule SugarlogappWeb.PageController do
  use SugarlogappWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
