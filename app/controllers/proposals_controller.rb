class ProposalsController < ApplicationController
	before_filter :check_for_user
	before_filter :find_chamber
  # GET /proposals
  # GET /proposals.json
  def index
    @proposals = @chamber.proposals.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @proposals }
    end
  end

  def inspect
	@proposal = Proposal.find(params[:id])
  end

  # GET /proposals/1
  # GET /proposals/1.json
  def show
    @proposal = Proposal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @proposal }
    end
  end

  # GET /proposals/new
  # GET /proposals/new.json
  def new
    @proposal = Proposal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @proposal }
    end
  end

  # GET /proposals/1/edit
  def edit
    @proposal = Proposal.find(params[:id])
  end

  # POST /proposals
  # POST /proposals.json
  def create
    @proposal = Proposal.new(params[:proposal])

    respond_to do |format|
      if @proposal.save
				Log.create(:user => current_user, :chamber => @chamber, :action_type => "Proposal", :action_id => @proposal.id, :comment => "created a new proposal")
        format.html { redirect_to [@chamber, @proposal], notice: 'Proposal was successfully created.' }
        format.json { render json: @proposal, status: :created, location: @proposal }
      else
        format.html { render action: "new" }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /proposals/1
  # PUT /proposals/1.json
  def update
    @proposal = Proposal.find(params[:id])

    respond_to do |format|
      if @proposal.update_attributes(params[:proposal])
        format.html { redirect_to @proposal, notice: 'Proposal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proposals/1
  # DELETE /proposals/1.json
  def destroy
    @proposal = Proposal.find(params[:id])
		if @proposal
		@chamber = @proposal.chamber
    @proposal.destroy
		Log.where(:action_type => "Proposal", :action_id => params[:id]).each do |l|
			l.destroy
		end

    respond_to do |format|
      format.html { redirect_to chamber_proposals_url(@chamber) }
      format.json { head :no_content }
    end
		else
			redirect_to session[:return_to], :notice => "Comment was already deleted."
		end
  end

  def vote
	@proposal = Proposal.find(params[:id])
	if ProposalRemark.where(:proposal_id => @proposal, :user_id => current_user.id).count > 0
		redirect_to [@chamber, @proposal], :info => 'You already voted.'
	else
		ProposalRemark.create!(:proposal_id => @proposal.id, :user_id => current_user.id, :remark => params[:remark])
		Log.create(:user => current_user, :chamber => @chamber, :action_type => "Proposal", :action_id => @proposal.id, :comment => "voted on a proposal")
		redirect_to [@chamber, @proposal], :info => 'Your vote has been submitted.'
	end
	end

  def close
	@proposal = Proposal.find(params[:id])
	@proposal.closed = true
	@proposal.save
		Log.create(:user => current_user, :chamber => @chamber, :action_type => "Proposal", :action_id => @proposal.id, :comment => "closed a proposal")
	redirect_to [@chamber, @proposal], :info => 'Closed proposal.'
  end

  def cancel
	@proposal = Proposal.find(params[:id])
	@proposal.voted?(current_user).delete
	redirect_to [@chamber, @proposal], :info => 'Your vote has been cancelled.'
  end
end
