require 'test_helper'

class PasswordControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get udpate" do
    get :udpate
    assert_response :success
  end

end
