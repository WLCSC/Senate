require 'test_helper'

class AnnouncementsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Announcement.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Announcement.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Announcement.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to announcement_url(assigns(:announcement))
  end

  def test_edit
    get :edit, :id => Announcement.first
    assert_template 'edit'
  end

  def test_update_invalid
    Announcement.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Announcement.first
    assert_template 'edit'
  end

  def test_update_valid
    Announcement.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Announcement.first
    assert_redirected_to announcement_url(assigns(:announcement))
  end

  def test_destroy
    announcement = Announcement.first
    delete :destroy, :id => announcement
    assert_redirected_to announcements_url
    assert !Announcement.exists?(announcement.id)
  end
end
