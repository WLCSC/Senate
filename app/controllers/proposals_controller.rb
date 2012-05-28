class ProposalsController < ApplicationController
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
    @proposal.destroy

    respond_to do |format|
      format.html { redirect_to proposals_url }
      format.json { head :no_content }
    end
  end

  def vote
	@proposal = Proposal.find(params[:id])
	ProposalRemark.create!(:proposal_id => @proposal.id, :user_id => current_user.id, :remark => (params[:commit] == "Yes!"))
	redirect_to [@chamber, @proposal], :info => 'Your vote has been submitted.'
  end

  def close
	@proposal = Proposal.find(params[:id])
	@proposal.closed = true
	@proposal.save
	redirect_to [@chamber, @proposal], :info => 'Closed proposal.'
  end

  def cancel
	@proposal = Proposal.find(params[:id])
	@proposal.voted?(current_user).delete
	redirect_to [@chamber, @proposal], :info => 'Your vote has been cancelled.'
  end
end
