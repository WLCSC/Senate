require 'test_helper'

class BallotsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Ballot.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Ballot.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Ballot.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to ballot_url(assigns(:ballot))
  end

  def test_edit
    get :edit, :id => Ballot.first
    assert_template 'edit'
  end

  def test_update_invalid
    Ballot.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Ballot.first
    assert_template 'edit'
  end

  def test_update_valid
    Ballot.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Ballot.first
    assert_redirected_to ballot_url(assigns(:ballot))
  end

  def test_destroy
    ballot = Ballot.first
    delete :destroy, :id => ballot
    assert_redirected_to ballots_url
    assert !Ballot.exists?(ballot.id)
  end
end
