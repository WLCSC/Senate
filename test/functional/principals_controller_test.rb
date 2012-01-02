require 'test_helper'

class PrincipalsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Principal.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Principal.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Principal.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to principal_url(assigns(:principal))
  end

  def test_edit
    get :edit, :id => Principal.first
    assert_template 'edit'
  end

  def test_update_invalid
    Principal.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Principal.first
    assert_template 'edit'
  end

  def test_update_valid
    Principal.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Principal.first
    assert_redirected_to principal_url(assigns(:principal))
  end

  def test_destroy
    principal = Principal.first
    delete :destroy, :id => principal
    assert_redirected_to principals_url
    assert !Principal.exists?(principal.id)
  end
end
