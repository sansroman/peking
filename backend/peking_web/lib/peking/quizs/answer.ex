defmodule Peking.Quizs.Answer do
  use Ecto.Schema
  import Ecto.Changeset


  schema "answers" do
    field :content, :string
    field :score, :integer
    belongs_to :user, Peking.Accounts.User, on_replace: :delete
    belongs_to :quiz, Peking.Quizs.Quiz, on_replace: :delete


    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:score, :content])
    |> validate_required([:content])
  end
end
