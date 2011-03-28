require 'test_helper'

class HostRedirectorTest < ActionController::TestCase
  tests MyController
  
  setup do
    @old_host = get_config_host
    set_config_host "localhost"
  end
  
  teardown do
    set_config_host @old_host
  end
  
  test "should get index" do
    request.host = "localhost"
    
    get :index
    assert_response :success
  end
  
  test "should redirect" do
    request.host = "127.0.0.1"

    get :index
    assert_redirected_to "http://localhost/"
  end
end
