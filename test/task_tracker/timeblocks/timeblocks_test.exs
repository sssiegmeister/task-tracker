defmodule TaskTracker.TimeblocksTest do
  use TaskTracker.DataCase

  alias TaskTracker.Timeblocks

  describe "timeblock" do
    alias TaskTracker.Timeblocks.Timeblock

    @valid_attrs %{end_time: ~N[2010-04-17 14:00:00], start_time: ~N[2010-04-17 14:00:00], task_id: 42}
    @update_attrs %{end_time: ~N[2011-05-18 15:01:01], start_time: ~N[2011-05-18 15:01:01], task_id: 43}
    @invalid_attrs %{end_time: nil, start_time: nil, task_id: nil}

    def timeblock_fixture(attrs \\ %{}) do
      {:ok, timeblock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Timeblocks.create_timeblock()

      timeblock
    end

    test "list_timeblock/0 returns all timeblock" do
      timeblock = timeblock_fixture()
      assert Timeblocks.list_timeblock() == [timeblock]
    end

    test "get_timeblock!/1 returns the timeblock with given id" do
      timeblock = timeblock_fixture()
      assert Timeblocks.get_timeblock!(timeblock.id) == timeblock
    end

    test "create_timeblock/1 with valid data creates a timeblock" do
      assert {:ok, %Timeblock{} = timeblock} = Timeblocks.create_timeblock(@valid_attrs)
      assert timeblock.end_time == ~N[2010-04-17 14:00:00]
      assert timeblock.start_time == ~N[2010-04-17 14:00:00]
      assert timeblock.task_id == 42
    end

    test "create_timeblock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timeblocks.create_timeblock(@invalid_attrs)
    end

    test "update_timeblock/2 with valid data updates the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, %Timeblock{} = timeblock} = Timeblocks.update_timeblock(timeblock, @update_attrs)
      assert timeblock.end_time == ~N[2011-05-18 15:01:01]
      assert timeblock.start_time == ~N[2011-05-18 15:01:01]
      assert timeblock.task_id == 43
    end

    test "update_timeblock/2 with invalid data returns error changeset" do
      timeblock = timeblock_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeblocks.update_timeblock(timeblock, @invalid_attrs)
      assert timeblock == Timeblocks.get_timeblock!(timeblock.id)
    end

    test "delete_timeblock/1 deletes the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, %Timeblock{}} = Timeblocks.delete_timeblock(timeblock)
      assert_raise Ecto.NoResultsError, fn -> Timeblocks.get_timeblock!(timeblock.id) end
    end

    test "change_timeblock/1 returns a timeblock changeset" do
      timeblock = timeblock_fixture()
      assert %Ecto.Changeset{} = Timeblocks.change_timeblock(timeblock)
    end
  end
end
