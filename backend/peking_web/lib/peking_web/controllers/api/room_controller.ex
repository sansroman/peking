defmodule PekingWeb.Api.RoomController do
  use PekingWeb, :controller
  plug :authenticate_user

  alias Peking.Rooms
  alias Peking.Rooms.Room

  action_fallback PekingWeb.FallbackController

  def index(conn, _params) do
    rooms = Rooms.list_rooms()
    render(conn, "index.json", rooms: rooms)
  end

  def create(conn, %{"room" => room_params}) do
    with {:ok, %Room{} = room} <- Rooms.create_room(room_params) do
      conn
      |> put_status(:created)
      |> render("show.json", room: room)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Rooms.get_room!(id)
    render(conn, "show.json", room: room)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Rooms.get_room!(id)

    with {:ok, %Room{} = room} <- Rooms.update_room(room, room_params) do
      render(conn, "show.json", room: room)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Rooms.get_room!(id)

    with {:ok, %Room{}} <- Rooms.delete_room(room) do
      send_resp(conn, :no_content, "")
    end
  end

  def discuss(conn, %{"title" => title, "time"=> time}) do
    case conn.assigns.current_user do
      %{:room => room} ->
        PekingWeb.Endpoint.broadcast!("room:" <> Integer.to_string(room.id), "discuss_start", %{title: title, time: time})
        json(conn, %{status: true, room_id: room.id})
      _ ->
        json(conn, %{status: false, error: "doesn't have room"})
    end
  end

  def quiz(conn, %{"topic" => topic}) do
    case conn.assigns.current_user do
      %{:room => room} ->
        PekingWeb.Endpoint.broadcast!("room:" <> Integer.to_string(room.id), "quiz", %{topic: topic})
        json(conn, %{status: true, error: ""})
      _ ->
        json(conn, %{status: false, error: "doesn't have room"})
    end
  end

  def start(conn, %{"title" => title, "cover" => cover}) do
    case conn.assigns.current_user do
      %{:room => room} ->
        with {:ok, %Room{} = room} <- Rooms.update_room(room, %{title: title, cover: cover}) do
          token = Phoenix.Token.sign(PekingWeb.Endpoint, "token", room.id)
          json(conn, %{status: true, data: %{token: token}})
        else
          _ ->
            json(conn, %{status: false, error: "doesn't have room"})
        end
      _ ->
        json(conn, %{status: false, error: "doesn't have room"})
    end
  end

  def live_cb(conn, %{"token" => token, "room_id" => room_id}) do
    with {:ok, ^room_id} <- Phoenix.Token.verify(PekingWeb.Endpoint, "token", token, max_age: 1800) do
      json(conn, %{status: true, data: "room:#{room_id} started"})
    else
      _ ->
        json(conn, %{status: false, error: "token error"})
    end

  end
end
