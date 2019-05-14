defmodule Peking.Rooms.Room do
  use Ecto.Schema
  import Ecto.Changeset


  schema "rooms" do
    field :cover, :string
    field :desc, :string
    field :category, :string
    field :hot, :boolean, default: false
    field :title, :string
    belongs_to :user, Peking.Accounts.User


    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:title, :cover, :desc, :category, :hot])
    |> validate_required([:title, :cover, :desc, :category, :hot])
  end
end
