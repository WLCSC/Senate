require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

  test "should get override" do
    get :override
    assert_response :success
  end

  test "should get cancel_override" do
    get :cancel_override
    assert_response :success
  end

end
