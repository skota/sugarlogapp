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

    def render("success.json", %{readingid: id, message: message}) do
        %{  id:         id, 
            message:    message 
        }
    end    

    def render("forbidden.json", %{message: message}) do
        %{message: message}
    end    
    
    def render("error.json", %{changeset: changeset}) do
        %{errors: translate_errors(changeset)} 
    end

    def render("update.json", %{message: message}) do
        %{message: message}
    end    

  end
  