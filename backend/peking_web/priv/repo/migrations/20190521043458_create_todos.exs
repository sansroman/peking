defmodule Peking.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :status, :integer
      add :content, :string
      add :user_id, references(:users, on_delete: :delete_all, null: false)

      timestamps()
    end

  end
end
