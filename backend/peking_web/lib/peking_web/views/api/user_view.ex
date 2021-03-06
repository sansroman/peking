defmodule PekingWeb.Api.UserView do
  use PekingWeb, :view
  alias PekingWeb.Api.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      nickname: user.nickname,
      email: user.credential.email,
      role: user.role,
      avatar: user.avatar,
      introduction: user.introduction,
      rooms: user.rooms,
      room: user.room,
      created_at: user.inserted_at,
      todos: user.todos
    }
  end
end
