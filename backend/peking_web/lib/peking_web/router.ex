defmodule PekingWeb.Router do
  use PekingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PekingWeb.Auth
  end

  pipeline :api do
    plug :fetch_session
    plug :accepts, ["json"]
    plug PekingWeb.Auth
  end

  scope "/", PekingWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/sessions", SessionController
    resources "/users", UserController
    resources "/rooms", RoomController
  end

  scope "/api", PekingWeb.Api do
    pipe_through :api

    resources "/users", UserController
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete
    post "/rooms/discuss",  RoomController, :discuss
    post "/rooms/quiz",  RoomController, :quiz
    post "/rooms/start",  RoomController, :start
    post "/rooms/live_cb",  RoomController, :live_cb
    resources "/rooms", RoomController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PekingWeb do
  #   pipe_through :api
  # end
end
