require 'test_helper'

class TitlesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Title.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Title.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Title.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to title_url(assigns(:title))
  end

  def test_edit
    get :edit, :id => Title.first
    assert_template 'edit'
  end

  def test_update_invalid
    Title.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Title.first
    assert_template 'edit'
  end

  def test_update_valid
    Title.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Title.first
    assert_redirected_to title_url(assigns(:title))
  end

  def test_destroy
    title = Title.first
    delete :destroy, :id => title
    assert_redirected_to titles_url
    assert !Title.exists?(title.id)
  end
end
