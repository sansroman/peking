defmodule PekingWeb.Api.UserView do
  use PekingWeb, :view
  alias PekingWeb.Api.UserView
  alias Peking.Rooms.Room

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    case user do
      %{ room: nil } ->
        %{
          id: user.id,
          username: user.username,
          nickname: user.nickname,
          role: user.role,
          avatar: user.avatar,
          introduction: user.introduction,
          room: nil
        }
      _ ->
        %{
          id: user.id,
          username: user.username,
          nickname: user.nickname,
          role: user.role,
          avatar: user.avatar,
          introduction: user.introduction,
          room: %{id: user.room.id, cover: user.room.cover, title: user.room.title}
        }
    end
  end
end
