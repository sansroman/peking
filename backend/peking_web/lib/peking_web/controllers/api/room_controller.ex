defmodule PekingWeb.Api.RoomController do
  use PekingWeb, :controller
  plug :authenticate_user when action not in [:index, :live_cb]

  alias Peking.Rooms
  alias Peking.Rooms.Room
  alias Peking.UserRoom

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

    case Rooms.has_collected(get_session(conn, :user_id), id) do
      %UserRoom{} ->
        render(conn, "show.json", room: room, has_collection: true)
      _ ->
        render(conn, "show.json", room: room, has_collection: false)
    end
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

  def discuss(conn, %{"title" => title, "time" => time}) do
    case conn.assigns.current_user do
      %{:room => %{status: true, id: id}} ->
        PekingWeb.Endpoint.broadcast!("room:" <> Integer.to_string(id), "discuss_start", %{
          title: title,
          time: time
        })

        json(conn, %{status: true, room_id: id})

      _ ->
        json(conn, %{status: false, error: "doesn't have room or not living"})
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

  def stop(conn, _) do
    case conn.assigns.current_user do
      %{:room => room} ->
        with {:ok, %Room{} = room} <- Rooms.update_room(room, %{status: false})
        do
          json(conn, %{status: true, data: "room:#{room.id} stopped"})
        else
          _ ->
            json(conn, %{status: false, error: "stopped error"})
        end
      _ ->
        json(conn, %{status: false, error: "doesn't have room"})
    end
  end

  def live_cb(conn, %{"token" => token, "id" => id}) do
    {room_id, _} = Integer.parse(id)
    with room <- Rooms.get_room!(id),
         {:ok, ^room_id} <- Phoenix.Token.verify(PekingWeb.Endpoint, "token", token, max_age: 1800),
         {:ok, %Room{} = room} <- Rooms.update_room(room, %{status: true})
    do
      json(conn, %{status: true, data: "room:#{room.id} started"})
    else
      _ ->
        json(conn, %{status: false, error: "token error"})
    end
  end

  def collect(conn, %{"room_id" => room_id}) do
    {room_id, _} = Integer.parse(room_id)
    case conn
      |> get_session(:user_id)
      |> Rooms.collect(room_id)
    do
      {:ok, _} ->
        json(conn, %{status: true, data: "collect successful"})
      _ ->
      json(conn, %{status: false, data: "collect failed"})
    end

  end

  def cancel_collect(conn, %{"room_id" => room_id}) do
    case conn
    |> get_session(:user_id)
    |> Rooms.cancel_collect(room_id)
    do
      {:ok, _} ->
      json(conn, %{status: true, data: "cancel successful"})
      _ ->
      json(conn, %{status: false, data: "cancel failed"})
    end
  end



  def hot(conn, _) do
    rooms = Rooms.hot()
    render(conn, "index.json", rooms: rooms)
  end

  def my_collect(conn, _) do
    %{rooms: rooms} = conn
      |> get_session(:user_id)
      |> Rooms.my_collect()
    render(conn, "index.json", rooms: rooms)
  end

  def users(conn, %{"room_id" => room_id}) do
    %{users: users} = Rooms.users(room_id)
    json(conn, %{users: users})
  end
end
