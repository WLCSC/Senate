require 'test_helper'

class BallotRemarksControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => BallotRemark.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    BallotRemark.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    BallotRemark.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to ballot_remark_url(assigns(:ballot_remark))
  end

  def test_edit
    get :edit, :id => BallotRemark.first
    assert_template 'edit'
  end

  def test_update_invalid
    BallotRemark.any_instance.stubs(:valid?).returns(false)
    put :update, :id => BallotRemark.first
    assert_template 'edit'
  end

  def test_update_valid
    BallotRemark.any_instance.stubs(:valid?).returns(true)
    put :update, :id => BallotRemark.first
    assert_redirected_to ballot_remark_url(assigns(:ballot_remark))
  end

  def test_destroy
    ballot_remark = BallotRemark.first
    delete :destroy, :id => ballot_remark
    assert_redirected_to ballot_remarks_url
    assert !BallotRemark.exists?(ballot_remark.id)
  end
end
