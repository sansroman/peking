defmodule PekingWeb.RoomChannel do
  use Phoenix.Channel
  alias Peking.Accounts
  alias Peking.Rooms

  def join("room:" <> room_id, _params, socket) do
    ChannelWatcher.monitor(:rooms, self(), {__MODULE__, :leave, [room_id]})
    Rooms.incoming(room_id)

    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body, "uid" => uid}, socket) do
    user = Accounts.get_user!(uid)
    broadcast!(socket, "new_msg", %{body: body, nickname: user.nickname, timestamp: NaiveDateTime.utc_now})
    {:reply, :ok, socket}
  end

  def leave(room_id) do
    Rooms.outcoming(room_id)
  end


end
