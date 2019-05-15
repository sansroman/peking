defmodule Peking.Repo.Migrations.AddStatusRoom do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      add :status, :boolean
    end
  end
end
