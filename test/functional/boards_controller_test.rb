require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
  setup do
    @board = boards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create board" do
    assert_difference('Board.count') do
      post :create, board: @board.attributes
    end

    assert_redirected_to board_path(assigns(:board))
  end

  test "should show board" do
    get :show, id: @board
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @board
    assert_response :success
  end

  test "should update board" do
    put :update, id: @board, board: @board.attributes
    assert_redirected_to board_path(assigns(:board))
  end

  test "should destroy board" do
    assert_difference('Board.count', -1) do
      delete :destroy, id: @board
    end

    assert_redirected_to boards_path
  end
end
