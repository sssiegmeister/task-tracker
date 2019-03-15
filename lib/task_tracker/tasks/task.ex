defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  alias TaskTracker.Repo
  alias TaskTracker.Accounts.User

  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :title, :string
    belongs_to :user, TaskTracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :user_id])
    |> validate_required([:title, :description, :completed, :user_id])
  end

  @doc false
  def changeset(task, my_id, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :user_id])
    |> validate_required([:title, :description, :completed, :user_id])
    |> validate_inclusion(:user_id, valid_task_targets(my_id))
  end

  defp valid_task_targets(my_id) do
    Repo.all(User)
    |> Enum.filter(fn x -> x.id == my_id or x.manager_id == my_id end)
    |> Enum.map(fn x -> x.id end)
  end
end
