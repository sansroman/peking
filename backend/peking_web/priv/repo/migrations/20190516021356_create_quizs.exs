defmodule Peking.Repo.Migrations.CreateQuizs do
  use Ecto.Migration

  def change do
    create table(:quizs) do
      add :topic, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:quizs, [:user_id])
  end
end
