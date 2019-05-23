defmodule Peking.Accounts.TODO do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :status, :content]}
  schema "todos" do
    field :content, :string
    field :status, :integer
    belongs_to :user, Peking.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:status, :content])
    |> validate_required([:status, :content])
  end
end
