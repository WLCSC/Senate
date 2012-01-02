require 'test_helper'

class NewsItemsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => NewsItem.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    NewsItem.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    NewsItem.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to news_item_url(assigns(:news_item))
  end

  def test_edit
    get :edit, :id => NewsItem.first
    assert_template 'edit'
  end

  def test_update_invalid
    NewsItem.any_instance.stubs(:valid?).returns(false)
    put :update, :id => NewsItem.first
    assert_template 'edit'
  end

  def test_update_valid
    NewsItem.any_instance.stubs(:valid?).returns(true)
    put :update, :id => NewsItem.first
    assert_redirected_to news_item_url(assigns(:news_item))
  end

  def test_destroy
    news_item = NewsItem.first
    delete :destroy, :id => news_item
    assert_redirected_to news_items_url
    assert !NewsItem.exists?(news_item.id)
  end
end
