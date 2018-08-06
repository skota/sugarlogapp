#  test 
defmodule SugarlogappWeb.IntegrationTest do
    use SugarlogappWeb.ConnCase
    use ExUnit.Case
    use Hound.Helpers
  
    test "GET /", %{conn: conn} do
      conn = get conn, "/"
      assert html_response(conn, 200) =~ "yay121212"
    end

    # test "one equals one" do
    #     assert 1 = 1
    # end
    
    # test "one does not equal two" do
    #     assert 1 = 2
    # end
    hound_session()    
    test "" do
        navigate_to("/")
        elem = find_element(:id, "yay")
        element_text = inner_text(elem)
        # fill_field(element, "Happy Birthday ~!")
        # submit_element(element)
        assert element_text =~ "yay121212"
        # take_screenshot()        
    end

    

  end
  