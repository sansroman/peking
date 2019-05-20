defmodule Peking.Quizs.Quiz do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :topic]}
  schema "quizs" do
    field :topic, :string
    belongs_to :user, Peking.Accounts.User, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(quiz, attrs) do
    quiz
    |> cast(attrs, [:topic])
    |> validate_required([:topic])
  end
end
