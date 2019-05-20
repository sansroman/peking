defmodule PekingWeb.Api.RoomView do
  use PekingWeb, :view
  alias PekingWeb.Api.RoomView

  def render("index.json", %{rooms: rooms}) do
    %{data: render_many(rooms, RoomView, "room.json")}
  end

  def render("show.json", %{room: room, has_collection: has_collection}) do
    %{
      data: %{
        room: room,
        has_collection: has_collection
      }
    }
  end

  def render("room.json", %{room: room}) do
    %{id: room.id,
      title: room.title,
      cover: room.cover,
      desc: room.desc,
      category: room.category,
      status: room.status,
      hot: room.hot,
      online: room.online,
      owner: room.user.nickname,
      users: length(room.users)
    }
  end
end
