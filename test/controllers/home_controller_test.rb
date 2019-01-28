require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get user_data" do
    get :user_data
    assert_response :success
  end

  test "should get idea_data" do
    get :idea_data
    assert_response :success
  end

  test "should get user_view" do
    get :user_view
    assert_response :success
  end

  test "should get idea_view" do
    get :idea_view
    assert_response :success
  end

end
