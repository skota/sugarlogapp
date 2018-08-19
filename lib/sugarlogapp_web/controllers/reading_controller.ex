defmodule SugarlogappWeb.ReadingController do    
    use SugarlogappWeb, :controller 
    
    alias Sugarlogapp.Auth
    alias Sugarlogapp.Data
    alias Sugarlogapp.Guardian
    
    def index(conn, _params) do
        # get current user id
        current_user = Guardian.Plug.current_resource(conn)
        readings = Data.get_readings(current_user.id)
        IO.puts inspect readings

        render(conn, "index.json", readings: readings)
    end 
    
    def create(conn, %{"reading" => reading_params}) do
        # get current user id
        current_user = Guardian.Plug.current_resource(conn)
        
        reading_taken_dt = Map.get(reading_params,"reading_taken_dt")
        reading_taken_at = convert_string_to_datetime(conn, reading_taken_dt)    

        reading_attributes = %{"user_id" => current_user.id,
                         "reading" => Map.get(reading_params,"reading"), 
                         "time_of_day" => Map.get(reading_params,"time_of_day"), 
                         "reading_taken_dt" => reading_taken_at} 

        # try and create reading
        case Data.create_reading(reading_attributes) do
            {:ok, reading} ->                      
                conn
                |> put_status(201)
                |> render( "success.json", readingid: reading.id, message: "Created new reading")
            {:error, changeset} ->     
                conn
                |> put_status(401)
                |> render("error.json", changeset: changeset)
          end  
    end    

    defp convert_string_to_datetime(conn, string_to_date) do
        # TODO : store users time zone offset from UTC in settings
        # this value will be used to with Timex shift offset
        current_user = Guardian.Plug.current_resource(conn)

        # split string into parts - date time am/pm
        split_date_time = string_to_date |> String.split( " ")

        # split date into yyyy, mm, dd
        date_parts = Enum.at(split_date_time,0) |> String.split( "-")

        # split time into hh, mm, ss
        time_parts = Enum.at(split_date_time,1) |> String.split( ":")

        yr = Enum.at(date_parts,0) |> String.trim |> String.to_integer
        mm = Enum.at(date_parts,1) |> String.trim |> String.to_integer
        dd = Enum.at(date_parts,2) |> String.trim |> String.to_integer

        
        hr = Enum.at(time_parts,0) |> String.trim |> String.to_integer 
        # |> Timex.Time.to_24hour_clock(ampm)
        min = Enum.at(time_parts,1) |> String.trim |> String.to_integer
        sec = 0
        reading_taken_at = Timex.to_datetime({{yr,mm,dd}, {hr,min,sec}}, "Etc/UTC") 
        #    |> Timex.shift(hours: offset_hrs)        
    end    
end    