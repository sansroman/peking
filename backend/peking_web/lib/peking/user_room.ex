defmodule Peking.UserRoom do
  use Ecto.Schema

  alias Peking.Accounts.User
  alias Peking.Rooms.Room

  import Ecto.Changeset

  @primary_key false
  schema "user_rooms" do
    belongs_to :user, User, primary_key: true
    belongs_to :room, Room, primary_key: true

    timestamps() # Added bonus, a join schema will also allow you to set timestamps
  end

  @required_fields ~w(user_id room_id)a
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:room_id)
    |> foreign_key_constraint(:user_id)
  end
end
