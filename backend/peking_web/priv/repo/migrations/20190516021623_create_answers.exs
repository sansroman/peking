defmodule Peking.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :score, :integer
      add :content, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :quiz_id, references(:quizs, on_delete: :nothing)

      timestamps()
    end

    create index(:answers, [:user_id])
    create index(:answers, [:quiz_id])
  end
end
