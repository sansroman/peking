defmodule Peking.Rooms.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias Peking.Accounts.User

  @derive {Jason.Encoder, only: [:id, :cover, :desc, :category, :hot, :status, :title, :online]}
  schema "rooms" do
    field :cover, :string
    field :desc, :string
    field :category, :string
    field :hot, :boolean, default: false
    field :status, :boolean, default: false
    field :online, :integer, default: 0
    field :title, :string

    belongs_to :user, User, on_replace: :delete
    many_to_many :users, User, join_through: Peking.UserRoom, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:title, :cover, :desc, :category, :hot, :status, :online])
    |> validate_required([:title, :cover, :desc, :category, :hot, :status, :online])
  end
end
