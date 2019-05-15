defmodule Peking.Repo.Migrations.AddRoleUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :integer, default: 1
      add :avatar, :string, default: ""
      add :introduction, :string, default: "暂无介绍"
    end
  end
end
