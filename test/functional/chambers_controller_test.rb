require 'test_helper'

class ChambersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Chamber.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Chamber.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Chamber.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to chamber_url(assigns(:chamber))
  end

  def test_edit
    get :edit, :id => Chamber.first
    assert_template 'edit'
  end

  def test_update_invalid
    Chamber.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Chamber.first
    assert_template 'edit'
  end

  def test_update_valid
    Chamber.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Chamber.first
    assert_redirected_to chamber_url(assigns(:chamber))
  end

  def test_destroy
    chamber = Chamber.first
    delete :destroy, :id => chamber
    assert_redirected_to chambers_url
    assert !Chamber.exists?(chamber.id)
  end
end
