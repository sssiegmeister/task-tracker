defmodule TaskTracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :user, :string
      add :complete, :boolean, default: false, null: false
      add :title, :string
      add :description, :string

      timestamps()
    end

  end
end
