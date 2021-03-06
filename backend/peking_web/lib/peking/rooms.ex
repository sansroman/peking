defmodule Peking.Rooms do
  @moduledoc """
  The Rooms context.
  """

  import Ecto.Query, warn: false
  alias Peking.Repo

  alias Peking.Rooms.Room
  alias Peking.Accounts
  alias Peking.Accounts.User
  alias Peking.Repo
  alias Peking.UserRoom

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms do
    Room
    |> Repo.all()
    |> preload_user()
    |> Repo.preload(:users)
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(id) do
    Room
    |> Repo.get!(id)
    |> preload_user()
  end

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(%Accounts.User{} = user, attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> put_user(user)
    |> Repo.insert()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Ecto.Changeset{source: %Room{}}

  """
  def change_room(%Accounts.User{} = user, %Room{} = room) do
    room
    |> Room.changeset(%{})
    |> put_user(user)
  end

  defp put_user(changeset, user) do
    Ecto.Changeset.put_assoc(changeset, :user, user)
  end

  defp preload_user(room) do
    Repo.preload(room, :user)
  end


  def collect(user_id, room_id) do
    %UserRoom{}
    |> UserRoom.changeset(%{user_id: user_id, room_id: room_id})
    |> Repo.insert(on_conflict: :nothing)
  end

  def cancel_collect(user_id, room_id) do
    from(u in UserRoom, where: [user_id: ^user_id, room_id: ^room_id])
    |> Repo.one()
    |> Repo.delete()
  end

  def has_collected(user_id, room_id) do
    from(u in UserRoom, where: [user_id: ^user_id, room_id: ^room_id])
    |> Repo.one()
  end


  def hot do
    from(u in Room, where: [hot: true])
    |> Repo.all()
    |> preload_user()
  end

  def my_collect(user_id) do
    User
    |> Repo.get(user_id)
    |> Repo.preload([:rooms])
  end

  def incoming(room_id) do
    from(r in Room, update: [inc: [online: 1]], where: [id: ^room_id])
    |> Repo.update_all([])
  end

  def outcoming(room_id) do
    from(r in Room, update: [inc: [online: -1]], where: [id: ^room_id])
    |> Repo.update_all([])
  end

  def users(room_id) do
    Room
    |> Repo.get!(room_id)
    |> Repo.preload(:users)
  end
end
