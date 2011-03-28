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
  
  test "should redirect ip" do
    request.host = "127.0.0.1"

    get :index
    assert_permanently_redirected_to "http://localhost/my"
  end
  
  test "should redirect hostname" do
    request.host = "blah"

    get :index
    assert_permanently_redirected_to "http://localhost/my"
  end
  
  test "should redirect with port" do
    request.host = "blah:3000"

    get :index
    assert_permanently_redirected_to "http://localhost:3000/my"
  end
end
