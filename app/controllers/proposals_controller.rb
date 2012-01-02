class ProposalsController < ApplicationController
layout "chambers"
  def index
    @proposals = Proposal.all
  end

  def show
    @proposal = Proposal.find(params[:id])
	@chamber = @proposal.chamber
  end

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(params[:proposal])
    if @proposal.save
      redirect_to @proposal, :notice => "Successfully created proposal."
    else
      render :action => 'new'
    end
  end

  def edit
    @proposal = Proposal.find(params[:id])
  end

  def update
    @proposal = Proposal.find(params[:id])
    if @proposal.update_attributes(params[:proposal])
      redirect_to @proposal, :notice  => "Successfully updated proposal."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy
    redirect_to proposals_url, :notice => "Successfully destroyed proposal."
  end
  
  def close
	@proposal = Proposal.find(params[:id])
	@proposal.closed = params[:code]
	@proposal.save
	if @proposal.closed == 1
		flash[:notice] = "Proposal closed."
		@proposal.chamber.announce("Proposal #{@proposal.id}, #{@proposal.name}, has been closed.",current_user)
	elsif @proposal.closed == -1
		flash[:notice] = "Proposal killed."
		@proposal.chamber.announce("Proposal #{@proposal.id}, #{@proposal.name}, has been killed.",current_user)
	end
	redirect_to @proposal
  end
end
