defmodule PekingWeb.RoomChannel do
  use Phoenix.Channel
  alias Peking.Accounts

  def join("room:" <> room_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body, "uid" => uid}, socket) do
    user = Accounts.get_user!(uid)
    broadcast!(socket, "new_msg", %{body: body, nickname: user.nickname, timestamp: NaiveDateTime.utc_now})
    {:reply, :ok, socket}
  end

end
