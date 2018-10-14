defmodule Sugarlogapp.Data.Setting do
    use Ecto.Schema
    import Ecto.Changeset
    alias Sugarlogapp.Data.Setting

    #super important- if you want a sigil of atoms...add an 'a' at the end of sigil...see below
    # @required_fields ~w(reading time_of_day reading_taken_dt)a 
    @all_fields ~w(notifications reading_unit)a

    #schema definition
    schema "settings" do
        field :user_id, :integer
        field :notifications, :boolean
        field :reading_unit, :string
        timestamps()
    end
    
    def blank_changeset(%Setting{} = settings, attrs) do
        settings
        |> cast(attrs, @all_fields)
    end    

    def changeset(%Setting{} = setting, attrs) do
        setting
        |> cast(attrs, @all_fields )      
        |> validate_inclusion(:reading_unit, ~w(mmol/L mg/dL))             
      end
end