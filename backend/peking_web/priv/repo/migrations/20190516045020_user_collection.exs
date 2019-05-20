defmodule Peking.Repo.Migrations.UserCollection do
  use Ecto.Migration

  def change do
    create table(:user_rooms, primary_key: false) do
      add(:room_id, references(:rooms), primary_key: true)
      add(:user_id, references(:users), primary_key: true)
      timestamps()
    end

    create(index(:user_rooms, [:room_id]))
    create(index(:user_rooms, [:user_id]))

    create(
      unique_index(:user_rooms, [:user_id, :room_id], name: :user_id_room_id_unique_index)
    )
  end
end
