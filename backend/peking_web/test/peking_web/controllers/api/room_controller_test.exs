defmodule PekingWeb.Api.RoomControllerTest do
  use PekingWeb.ConnCase

  alias Peking.Rooms
  alias Peking.Rooms.Room

  @create_attrs %{
    cover: "some cover",
    desc: "some desc",
    hot: true,
    title: "some title"
  }
  @update_attrs %{
    cover: "some updated cover",
    desc: "some updated desc",
    hot: false,
    title: "some updated title"
  }
  @invalid_attrs %{cover: nil, desc: nil, hot: nil, title: nil}

  def fixture(:room) do
    {:ok, room} = Rooms.create_room(@create_attrs)
    room
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all rooms", %{conn: conn} do
      conn = get(conn, Routes.api_room_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create room" do
    test "renders room when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_room_path(conn, :create), room: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_room_path(conn, :show, id))

      assert %{
               "id" => id,
               "cover" => "some cover",
               "desc" => "some desc",
               "hot" => true,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_room_path(conn, :create), room: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update room" do
    setup [:create_room]

    test "renders room when data is valid", %{conn: conn, room: %Room{id: id} = room} do
      conn = put(conn, Routes.api_room_path(conn, :update, room), room: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_room_path(conn, :show, id))

      assert %{
               "id" => id,
               "cover" => "some updated cover",
               "desc" => "some updated desc",
               "hot" => false,
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, room: room} do
      conn = put(conn, Routes.api_room_path(conn, :update, room), room: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete room" do
    setup [:create_room]

    test "deletes chosen room", %{conn: conn, room: room} do
      conn = delete(conn, Routes.api_room_path(conn, :delete, room))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_room_path(conn, :show, room))
      end
    end
  end

  defp create_room(_) do
    room = fixture(:room)
    {:ok, room: room}
  end
end
