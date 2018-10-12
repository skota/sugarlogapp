defmodule SugarlogappWeb.ReadingWebView do
    use SugarlogappWeb, :view
    import Timex


    def show_order_date(reading) do
        if !reading do
            Timex.format!(Timex.now("America/New_York"), "{M}/{D}/{YYYY}")
        else
            Timex.format!(reading.reading_taken_dt, "{M}/{D}/{YYYY}")            
        end        
    end    

    # read timezone from settings
    # def show_order_time(reading,tz) do
        def show_order_time(reading) do    
        if !reading do
            Timex.format!(Timex.now("America/New_York"), "{h24}:{m}")
        else
            Timex.format!(reading.reading_taken_dt, "{h24}:{m}")            
        end        
    end   


    def show_order_date_time(reading) do
        if !reading do
            Timex.format!(Timex.now("America/New_York"), "{M}/{D}/{YYYY} {h24}:{m}")
        else
            Timex.format!(reading.reading_taken_dt, "{M}/{D}/{YYYY} {h24}:{m}")            
        end        
    end    

end
  