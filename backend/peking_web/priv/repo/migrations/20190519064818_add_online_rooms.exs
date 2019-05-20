defmodule Peking.Repo.Migrations.AddOnlineRooms do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      add :online, :integer, default: 0
    end
  end
end
