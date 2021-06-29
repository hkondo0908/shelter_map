defmodule ShelterMapWeb.PageController do
  use ShelterMapWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
