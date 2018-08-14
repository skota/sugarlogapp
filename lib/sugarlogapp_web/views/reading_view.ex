defmodule SugarlogappWeb.ReadingView do
    use SugarlogappWeb, :view
    
    def render("index.json", %{readings: readings}) do                 
        Enum.map(readings, fn reading ->
            render( "reading.json", reading: reading)
        end)
    end

    def render("reading.json", %{reading: reading}) do
        %{  id:         reading.id, 
            user_id:    reading.user_id, 
            reading_taken_dt:    reading.reading_taken_dt,
            time_of_day:   reading.time_of_day
        }        
    end

  end
  