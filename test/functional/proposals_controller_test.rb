require 'test_helper'

class ProposalsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Proposal.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Proposal.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Proposal.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to proposal_url(assigns(:proposal))
  end

  def test_edit
    get :edit, :id => Proposal.first
    assert_template 'edit'
  end

  def test_update_invalid
    Proposal.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Proposal.first
    assert_template 'edit'
  end

  def test_update_valid
    Proposal.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Proposal.first
    assert_redirected_to proposal_url(assigns(:proposal))
  end

  def test_destroy
    proposal = Proposal.first
    delete :destroy, :id => proposal
    assert_redirected_to proposals_url
    assert !Proposal.exists?(proposal.id)
  end
end
