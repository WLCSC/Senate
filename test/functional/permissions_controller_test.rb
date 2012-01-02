require 'test_helper'

class PermissionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Permission.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Permission.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Permission.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to permission_url(assigns(:permission))
  end

  def test_edit
    get :edit, :id => Permission.first
    assert_template 'edit'
  end

  def test_update_invalid
    Permission.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Permission.first
    assert_template 'edit'
  end

  def test_update_valid
    Permission.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Permission.first
    assert_redirected_to permission_url(assigns(:permission))
  end

  def test_destroy
    permission = Permission.first
    delete :destroy, :id => permission
    assert_redirected_to permissions_url
    assert !Permission.exists?(permission.id)
  end
end
