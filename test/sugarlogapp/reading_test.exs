defmodule Sugarlogapp.ReadingTest do
    use ExUnit.Case  
    alias Sugarlogapp.Data.Reading
    alias Sugarlogapp.Data
    import Timex.Time   

    @reading_dt Timex.to_datetime({{2018,8,6}, {15,48,0}}, "Etc/UTC") 
    @valid_attrs %{user_id: 1, reading: 120, time_of_day: "morning", reading_taken_dt:  @reading_dt}
    @invalid_attrs %{user_id: 2, reading: "a", time_of_day: "morning", reading_taken_dt: @reading_dt}
    @not_enough_attrs %{time_of_day: "morning", reading_take_dt: @reading_dt}

    setup do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(Sugarlogapp.Repo)
        Ecto.Adapters.SQL.Sandbox.mode(Sugarlogapp.Repo, {:shared, self()})
        :ok
    end

    test "changeset with valid attributes" do
        changeset = Reading.changeset(%Reading{}, @valid_attrs)
        assert changeset.valid?
    end
    
    test "changeset with invalid attributes" do
        changeset = Reading.changeset(%Reading{}, @invalid_attrs)
        refute changeset.valid?
    end

    test "changeset with not enough attributes" do
        changeset = Reading.changeset(%Reading{}, @not_enough_attrs)
        refute changeset.valid?
    end

    test "should be able to create new reading with valid attributes" do
        assert {:ok, reading} = Data.create_reading(@valid_attrs)
        assert reading.user_id == 1
        assert reading.reading == 120
        assert reading.time_of_day == "morning"        
    end    

end