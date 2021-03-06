defmodule Sugarlogapp.Data.Reading do
    use Ecto.Schema
    import Ecto.Changeset
    alias Sugarlogapp.Data.Reading

    #super important- if you want a sigil of atoms...add an 'a' at the end of sigil...see below
    @required_fields ~w(reading time_of_day reading_taken_dt)a 
    @all_fields ~w(user_id reading time_of_day reading_taken_dt notes)a

    #schema definition
    schema "readings" do
        field :user_id, :integer
        field :reading, :integer
        field :time_of_day, :string
        field :reading_taken_dt, :utc_datetime
        field :notes, :string
        timestamps()
    end
    
    #only these fields can be cast
    def blank_changeset(%Reading{} = reading, attrs) do
        reading
        |> cast(attrs, @all_fields)
    end    

    def changeset(%Reading{} = reading, attrs) do        
        reading
        |> cast(attrs, @all_fields)        
        |> validate_required(@required_fields)        
    end

    def update_changeset(%Reading{} = reading, attrs) do    
        reading
        |> cast(attrs, @all_fields )        
        # |> validate_number(:reading, greater_than: 0)
        
        # |> validate_number(:consistency, greater_than: 0)
        # |> validate_inclusion(:measurement, ~w(ml cc oz))      
      end


end