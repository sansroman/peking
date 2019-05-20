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
    resources "/quizs", QuizController
    resources "/answers", AnswerController
  end

  scope "/api", PekingWeb.Api do
    pipe_through :api

    resources "/users", UserController
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete
    get "/rooms/hot", RoomController, :hot
    get "/rooms/my_collect", RoomController, :my_collect
    get "/rooms/users", RoomController, :users
    post "/rooms/discuss",  RoomController, :discuss
    post "/rooms/start",  RoomController, :start
    get "/rooms/stop",  RoomController, :stop
    post "/rooms/live_cb",  RoomController, :live_cb
    get  "/rooms/collect/:room_id", RoomController, :collect
    delete  "/rooms/collect/:room_id", RoomController, :cancel_collect
    resources "/rooms", RoomController
    resources "/quizs", QuizController
    get "/answers/me", AnswerController, :me
    get "/answers/own", AnswerController, :own
    resources "/answers", AnswerController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PekingWeb do
  #   pipe_through :api
  # end
end
