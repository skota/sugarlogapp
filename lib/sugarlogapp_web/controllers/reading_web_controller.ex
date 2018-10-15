defmodule SugarlogappWeb.ReadingWebController do    
    use SugarlogappWeb, :controller 
    
    # alias Sugarlogapp.Auth
    alias Sugarlogapp.Data
    alias Sugarlogapp.Data.Reading
    alias Sugarlogapp.Guardian
 
    plug :put_layout, "dashboard.html" 

    def action(conn, _) do
        settings=get_session(conn, :setting)
        
        args = [conn, conn.params,  settings.current_user_name]
        apply(__MODULE__, action_name(conn), args)
    end

    def index(conn, _params, current_user_name) do
        IO.puts "------------"
        IO.puts current_user_name

        # get current user id        
        current_user = Guardian.Plug.current_resource(conn)
        setting = get_session(conn, :setting)   

        readings = Data.get_readings(current_user.id)
        render(conn, "index.html", 
                    readings: readings, 
                    reading_unit: setting.user_settings.reading_unit,
                    current_user_name: current_user_name)
    end 

    def new(conn, _, current_user_name) do
        changeset = Data.build_reading()       
        render(conn, "new.html",
                    reading: nil,
                    reading_time_of_day: "",
                    reading_notes: "",
                    changeset: changeset, 
                    current_user_name: current_user_name,
                    mode: "Create")
    end   
    
    def create(conn, %{"reading" => reading_params}) do
        current_user = Guardian.Plug.current_resource(conn)
        
        reading_date = reading_params |> Map.get("reading_date")
        reading_time = reading_params |> Map.get("reading_time")
        reading_datetime= build_datetime(reading_date,reading_time )

        reading_attributes = %{"user_id" => current_user.id,
                         "reading" => Map.get(reading_params, "reading"), 
                         "time_of_day" => Map.get(reading_params, "time_of_day"), 
                         "reading_taken_dt" => reading_datetime,
                         "notes" => Map.get(reading_params, "notes")} 

        # try and create reading
        case Data.create_reading(reading_attributes) do
            {:ok, reading} ->                      
                conn
                |> put_flash(:info, "Reading created successfully")
                |> redirect(to: "/readings")

            {:error, changeset} ->     
                render conn, "edit.html",reading: nil, 
                            reading_time_of_day: "", 
                            changeset: changeset, 
                            mode: "Edit"                          
        end  
    end   
    
    def edit(conn, %{"id" => id}, current_user_name) do 
        user = Guardian.Plug.current_resource(conn)
        reading = Data.get_reading(id, user.id)

        changeset = Reading.blank_changeset(reading, %{})

        render(conn, "edit.html",   reading: reading, 
                                    reading_time_of_day: reading.time_of_day,
                                    reading_notes: reading.notes,
                                    changeset: changeset, 
                                    current_user_name: current_user_name,
                                    mode: "Edit")
    end  

    def update(conn, %{"id" => id, "reading" => reading_params}) do
        user = Guardian.Plug.current_resource(conn)
        
        reading_date = reading_params |> Map.get("reading_date")
        reading_time = reading_params |> Map.get("reading_time")
        reading_datetime= build_datetime(reading_date,reading_time )

        reading_attributes = %{"user_id" => user.id,
                    "reading" => Map.get(reading_params, "reading"), 
                    "time_of_day" => Map.get(reading_params, "time_of_day"), 
                    "reading_taken_dt" => reading_datetime,
                    "notes" => Map.get(reading_params, "notes")} 
        
        case Data.get_reading(id, user.id) do
            reading ->    
                case Data.update_reading!(reading, reading_attributes) do
                    {:ok, _reading} ->      
                        conn
                        |> put_flash(:info, "Reading updated successfully")
                        |> redirect(to: "/readings")
                    {:error, changeset} ->            
                        render conn, "edit.html",
                            reading: reading, changeset: 
                            changeset, 
                            mode: "Edit"                
                end
            nil  ->    
                conn
                |> put_flash(:info, "Reading not found")
                |> redirect(to: "/readings")
        end    

    end    
    
    def delete(conn, %{"id" => id}) do
        user = Guardian.Plug.current_resource(conn)

        conn
        |> put_flash(:info, "Reading updated successfully")
        |> redirect(to: "/readings")

        case Data.get_reading(id, user.id) do
            nil ->
                conn
                |> put_flash(:error, "Reading not found")
                |> redirect(to: "/readings")
            reading ->
                with {:ok, %Reading{}} <- Data.delete_reading!(reading) do
                    conn
                    |> put_flash(:info, "Reading deleted")
                    |> redirect(to: "/readings")
                end
        end    

    end

    defp build_datetime(reading_date, reading_time) do
        # TODO : store users time zone offset from UTC in settings
        # this value will be used to with Timex shift offset
        # TODO:  show 24hr time in human readable form

        # split string into parts - date time am/pm
        # split_date_time = string_to_date |> String.split( " ")

        # split date into yyyy, mm, dd
        date_parts = reading_date |> String.split( ".")
        # split time into hh, mm
        time_parts = reading_time |> String.split( ":")

        mm = date_parts |> Enum.at(0) |> String.trim |> String.to_integer
        dd = date_parts |> Enum.at(1) |> String.trim |> String.to_integer
        yr = date_parts |> Enum.at(2) |> String.trim |> String.to_integer

        hr =  time_parts |> Enum.at(0) |> String.trim |> String.to_integer 
        # |> Timex.Time.to_24hour_clock(ampm)
        min = time_parts |> Enum.at(1) |> String.trim |> String.to_integer
        sec = 0
        Timex.to_datetime({{yr, mm, dd}, {hr, min, sec}}, "America/New_York") 
        #    |> Timex.shift(hours: offset_hrs)        
    end
end    