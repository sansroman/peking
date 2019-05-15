defmodule PekingWeb.Api.RoomView do
  use PekingWeb, :view
  alias PekingWeb.Api.RoomView

  def render("index.json", %{rooms: rooms}) do
    %{data: render_many(rooms, RoomView, "room.json")}
  end

  def render("show.json", %{room: room}) do
    %{data: render_one(room, RoomView, "room.json")}
  end

  def render("room.json", %{room: room}) do
    %{id: room.id,
      title: room.title,
      cover: room.cover,
      desc: room.desc,
      category: room.category,
      status: room.status,
      hot: room.hot}
  end
end
