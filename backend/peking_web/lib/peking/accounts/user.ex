defmodule Peking.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Peking.Accounts.Credential
  alias Peking.Rooms.Room

  schema "users" do
    field :nickname, :string
    field :username, :string
    field :avatar, :string
    field :introduction, :string
    field :role, :integer

    has_one :credential, Credential
    has_one :room, Room, on_replace: :update

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :nickname, :role, :avatar, :introduction])
    |> validate_required([:username, :nickname, :role])
    |> validate_length(:username, min: 5, max: 20)
  end

  def registration_changeset(user, params) do
    user
    |> changeset(params)
    |> cast_assoc(:credential, with: &Credential.changeset/2, required: true)
  end
end
