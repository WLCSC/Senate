require 'test_helper'

class ProposalRemarksControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => ProposalRemark.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    ProposalRemark.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    ProposalRemark.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to proposal_remark_url(assigns(:proposal_remark))
  end

  def test_edit
    get :edit, :id => ProposalRemark.first
    assert_template 'edit'
  end

  def test_update_invalid
    ProposalRemark.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ProposalRemark.first
    assert_template 'edit'
  end

  def test_update_valid
    ProposalRemark.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ProposalRemark.first
    assert_redirected_to proposal_remark_url(assigns(:proposal_remark))
  end

  def test_destroy
    proposal_remark = ProposalRemark.first
    delete :destroy, :id => proposal_remark
    assert_redirected_to proposal_remarks_url
    assert !ProposalRemark.exists?(proposal_remark.id)
  end
end
