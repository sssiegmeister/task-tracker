defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :complete, :boolean, default: false
    field :description, :string
    field :title, :string
    field :user, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:user, :complete, :title, :description])
    |> validate_required([:user, :complete, :title, :description])
  end
end
