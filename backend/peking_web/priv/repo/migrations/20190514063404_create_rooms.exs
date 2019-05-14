defmodule Peking.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :title, :string
      add :cover, :string
      add :desc, :string
      add :category, :string
      add :hot, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :delete_all, null: false)

      timestamps()
    end

    create index(:rooms, [:user_id])
  end
end
