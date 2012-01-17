class ProposalRemarksController < ApplicationController
before_filter :find_chamber
layout "chambers"

def find_chamber
	if params[:chamber_id]
		@chamber = Chamber.find params[:chamber_id]
	end
	if params[:proposal_id]
		@chamber = Proposal.find(params[:proposal_id]).chamber
	end
end	
  def index
	if params[:proposal_id]
	    @proposal_remarks = Proposal.find(params[:proposal_id]).remarks
	else
	    @proposal_remarks = ProposalRemark.all
	end
  end

  def show
    @proposal_remark = ProposalRemark.find(params[:id])
	redirect_to @proposal_remark.proposal
  end

  def new
    @proposal_remark = ProposalRemark.new
  end

  def create
    @proposal_remark = ProposalRemark.new(params[:proposal_remark])
    if @proposal_remark.save
      redirect_to @proposal_remark, :notice => "Successfully created proposal remark."
    else
      render :action => 'new'
    end
  end

  def edit
    @proposal_remark = ProposalRemark.find(params[:id])
  end

  def update
    @proposal_remark = ProposalRemark.find(params[:id])
    if @proposal_remark.update_attributes(params[:proposal_remark])
      redirect_to @proposal_remark, :notice  => "Successfully updated proposal remark."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @proposal_remark = ProposalRemark.find(params[:id])
    @proposal_remark.destroy
    redirect_to @proposal_remark.proposal, :notice => "Successfully destroyed proposal remark."
  end
end
