defmodule TaskTrackerWeb.TimeblockView do
  use TaskTrackerWeb, :view
  alias TaskTrackerWeb.TimeblockView

  def render("index.json", %{timeblock: timeblock}) do
    %{data: render_many(timeblock, TimeblockView, "timeblock.json")}
  end

  def render("show.json", %{timeblock: timeblock}) do
    %{data: render_one(timeblock, TimeblockView, "timeblock.json")}
  end

  def render("timeblock.json", %{timeblock: timeblock}) do
    %{id: timeblock.id,
      start_time: timeblock.start_time,
      end_time: timeblock.end_time,
      task_id: timeblock.task_id}
  end
end
