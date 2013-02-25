require 'test_helper'

class TagControllerTest < ActionController::TestCase
  test "should get tag" do
    get :tag
    assert_response :success
  end

  test "should get untag" do
    get :untag
    assert_response :success
  end

  test "should get tagged" do
    get :tagged
    assert_response :success
  end

end
