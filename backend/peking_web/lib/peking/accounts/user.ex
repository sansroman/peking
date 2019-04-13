defmodule Peking.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Peking.Accounts.Credential

  schema "users" do
    field :nickname, :string
    field :username, :string
    has_one :credentials, Credential

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :nickname])
    |> validate_required([:username, :nickname])
    |> validate_length(:username, min: 5, max: 20)
  end

  def registration_changeset(user, params) do
    user
    |> changeset(params)
    |> cast_assoc(:credentials, with: &Credential.changeset/2, required: true)
  end
end
