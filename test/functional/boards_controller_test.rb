require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Board.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Board.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Board.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to board_url(assigns(:board))
  end

  def test_edit
    get :edit, :id => Board.first
    assert_template 'edit'
  end

  def test_update_invalid
    Board.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Board.first
    assert_template 'edit'
  end

  def test_update_valid
    Board.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Board.first
    assert_redirected_to board_url(assigns(:board))
  end

  def test_destroy
    board = Board.first
    delete :destroy, :id => board
    assert_redirected_to boards_url
    assert !Board.exists?(board.id)
  end
end
