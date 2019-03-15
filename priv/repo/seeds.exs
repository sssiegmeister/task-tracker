alias TaskTracker.Repo
alias TaskTracker.Accounts.User
alias TaskTracker.Tasks.Task
alias TaskTracker.Timeblocks.Timeblock

Repo.insert!(%User{name: "Alice"})
Repo.insert!(%User{name: "Bob", manager_id: 1})
Repo.insert!(%User{name: "CJ", manager_id: 2})

Repo.insert!(%Task{
  title: "Homework",
  description: "HW06",
  completed: true,
  user_id: 3
})

Repo.insert!(%Task{
  title: "Clean room",
  description: "Please",
  completed: false,
  user_id: 2
})

Repo.insert!(%Task{
  title: "Apply for co-op",
  description: "At Facebook",
  completed: false,
  user_id: 2
})

Repo.insert!(%Timeblock{
  task_id: 2,
  start_time: ~N[2000-01-01 23:00:07],
  end_time: ~N[2000-01-01 23:00:08]
})
