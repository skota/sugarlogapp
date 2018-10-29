defmodule SugarlogappWeb.ReadingController do    
    use SugarlogappWeb, :controller 
    
    # alias Sugarlogapp.Auth
    alias Sugarlogapp.Data
    alias Sugarlogapp.Data.Reading
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
        
        reading_taken_at = reading_params 
                            |> Map.get("reading_taken_dt")
                            |>  convert_string_to_datetime()    

        reading_attributes = %{"user_id" => current_user.id,
                         "reading" => Map.get(reading_params, "reading"), 
                         "time_of_day" => Map.get(reading_params, "time_of_day"), 
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

    def delete(conn, %{"id" => id}) do
        user = Guardian.Plug.current_resource(conn)

        case Data.get_reading!(id, user.id) do
            nil ->
                conn
                |> put_status(403)      
                |> render( "forbidden.json", message: "You cannot delete readings you do not own")  
            reading ->
                with {:ok, %Reading{}} <- Data.delete_reading!(reading) do
                    send_resp(conn, :no_content, "")
                end
        end    

    end

    def update(conn, %{"id" => id, "reading" => reading_params}) do
        user = Guardian.Plug.current_resource(conn)

        # if map has reading_take_dt then try and transform it
        if Map.has_key?(reading_params, "reading_taken_dt") do
            reading_date = reading_params |> Map.get("reading_taken_dt")
                        |> convert_string_to_datetime()

            Map.replace!(reading_params, "reading_taken_dt", reading_date)            
        end    

        case Data.get_reading!(id, user.id) do
            {:ok, reading} ->
                case Data.update_reading!(reading, reading_params) do
                    {:ok, _updated_reading} ->      
                        notify_result(conn, "Update successful", 200)    
                    {:error, changeset} ->            
                        notify_error(conn, changeset, 401)
                end
            nil  ->    
                notify_result(conn, "Error: Reading not found", 401)    
        end    

    end    

    defp notify_error(conn, changeset, status) do
        conn
        |> put_status(status)
        |> render("error.json", changeset: changeset)
    end
    
    defp notify_result(conn, msg, status) do
        conn
        |> put_status(status)      
        |> render( "update.json", message: msg)  
    end    

    defp convert_string_to_datetime(string_to_date) do
        # TODO : store users time zone offset from UTC in settings
        # this value will be used to with Timex shift offset

        # split string into parts - date time am/pm
        split_date_time = string_to_date |> String.split( " ")

        # split date into yyyy, mm, dd
        date_parts = split_date_time |> Enum.at(0) |> String.split( "-")

        # split time into hh, mm, ss
        time_parts = split_date_time |> Enum.at(1) |> String.split( ":")

        yr = date_parts |> Enum.at(0) |> String.trim |> String.to_integer
        mm = date_parts |> Enum.at(1) |> String.trim |> String.to_integer
        dd = date_parts |> Enum.at(2) |> String.trim |> String.to_integer

        
        hr =  time_parts |> Enum.at(0) |> String.trim |> String.to_integer 
        # |> Timex.Time.to_24hour_clock(ampm)
        min = time_parts |> Enum.at(1) |> String.trim |> String.to_integer
        sec = 0
        Timex.to_datetime({{yr, mm, dd}, {hr, min, sec}}, "Etc/UTC") 
        #    |> Timex.shift(hours: offset_hrs)        
    end    
end    