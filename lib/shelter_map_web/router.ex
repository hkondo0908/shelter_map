defmodule ShelterMapWeb.Router do
  use ShelterMapWeb, :router

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

  scope "/", ShelterMapWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/page/area", PageController, :showArea
    resources "/place", PlaceController
    get "/place/new/file", PlaceController, :newFile
    post "/place/create/file", PlaceController, :createFile
    get "/place/create/:list", PlaceController, :createList
    delete "/place/delete/all/all", PlaceController, :deleteAll
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShelterMapWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ShelterMapWeb.Telemetry
    end
  end
end
