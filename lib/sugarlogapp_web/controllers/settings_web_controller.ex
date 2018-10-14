defmodule SugarlogappWeb.SettingsWebController do
    use SugarlogappWeb, :controller    
    alias Sugarlogapp.Data
    alias Sugarlogapp.Data.Setting
    alias Sugarlogapp.Guardian
    use Timex
    
    plug :put_layout, "dashboard.html"

    def index(conn, _params) do 
      user = Guardian.Plug.current_resource(conn)
      
      setting = Data.get_setting(user.id)
      IO.puts inspect setting
      if setting.notifications == true do
        current_notification_setting = "Yes"
      else
        current_notification_setting = "No"
      end  

      changeset = Setting.blank_changeset(setting, %{})
      render conn, "form.html", changeset: changeset, 
                    setting: setting, 
                    notification_setting: current_notification_setting
    end  
    
    #only specific fields should be updateable    
    def update(conn, %{"id" => id, "setting" => setting_params}) do
      user = Guardian.Plug.current_resource(conn)
      user_setting = Data.get_setting(user.id)

      notifications = setting_params["notifications"]
      
      if notifications == "Yes" do
        push_notifications = false  
      else
        push_notifications = true  
      end    
      updated_settings = %{"reading_unit" => setting_params["reading_unit"],
                          "notifications" => push_notifications,
                          "notes" => setting_params["notes"]}
      
      # params - convert true false to boolean
      case Data.update_setting(user_setting, updated_settings) do
        {:ok, setting} ->        
            
            # conn
            # |> put_session(:setting, 
            #                   %{current_user: user.first_name,
            #                     measurement: setting.measurement, 
            #                     output_max: setting.output_max,
            #                     currency: setting.currency,
            #                     paginate_rows: setting.paginate_rows,
            #                     timezone: setting.timezone,
            #                     timezone_offset: setting.timezone_offset})
            conn
            |> put_flash(:info, "Settings updated successfully")
            |> redirect(to: "/settings")
        {:error, changeset} ->            
            IO.puts inspect changeset
            render conn, "edit.html",setting: user_setting, changeset: changeset
      end
    end
  end
  