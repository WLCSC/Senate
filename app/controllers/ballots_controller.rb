class BallotsController < ApplicationController
	before_filter :find_chamber
	before_filter :check_for_user
	# GET /ballots
	# GET /ballots.json
	def index
		@ballots = @chamber.ballots.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @ballots }
		end
	end

	# GET /ballots/1
	# GET /ballots/1.json
	def show
		@ballot = Ballot.find(params[:id])
		unless @ballot.can?(current_user, :read) || current_user.admin?
			redirect_to @ballot.chamber, :error => "Access Denied" 
		else
			respond_to do |format|
				format.html # show.html.erb
				format.json { render json: @ballot }
			end
		end
	end

	def inspect
		@ballot = Ballot.find(params[:id])
	end

	# GET /ballots/new
	# GET /ballots/new.json
	def new
		@ballot = Ballot.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @ballot }
		end
	end

	# POST /ballots
	# POST /ballots.json
	def create
		@ballot = Ballot.new(params[:ballot])
		@ballot.set_options

		unless @ballot.chamber.can?(current_user, :read)
			redirect_to @ballot.chamber, :error => "Access Denied" 
		end

		respond_to do |format|
			if @ballot.save
				Log.create(:user => current_user, :chamber => @chamber, :action_type => "Ballot", :action_id => @ballot.id, :comment => "created a new ballot")
				format.html { redirect_to [@chamber,@ballot], notice: 'Ballot was successfully created.' }
				format.json { render json: @ballot, status: :created, location: @ballot }
			else
				format.html { render action: "new" }
				format.json { render json: @ballot.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /ballots/1
	# DELETE /ballots/1.json
	def destroy
		@ballot = Ballot.find(params[:id])
		if @ballot
			@ballot.destroy

				Log.create(:user => current_user, :chamber => @chamber, :action_type => nil, :action_id => nil, :comment => "removed a ballot")
			respond_to do |format|
				format.html { redirect_to chamber_ballots_url(@chamber) }
				format.json { head :no_content }
			end
		else
			redirect_to session[:return_to], :notice => "Ballot was already deleted."
		end
	end

	def vote
		@ballot = Ballot.find(params[:id])
		if BallotRemark.where(:ballot_id => @ballot.id, :user_id => current_user.id).count > 0
			redirect_to [@chamber, @ballot], :info => 'You already voted.'
		else
			BallotRemark.create!(:ballot_id => @ballot.id, :user_id => current_user.id, :remark => params[:remark])
			Log.create(:user => current_user, :chamber => @chamber, :action_type => "Ballot", :action_id => @ballot.id, :comment => "voted on a ballot")
			redirect_to [@chamber, @ballot], :info => 'Your vote has been submitted.'
		end
	end

	def close
		@ballot = Ballot.find(params[:id])
		@ballot.closed = true
		@ballot.save
		redirect_to [@chamber, @ballot], :info => 'Closed ballot.'
		Log.create(:user => current_user, :chamber => @chamber, :action_type => "Ballot", :action_id => @ballot.id, :comment => "closed a ballot")
	end

	def cancel
		@ballot = Ballot.find(params[:id])
		@ballot.voted?(current_user).delete
		redirect_to [@chamber, @ballot], :info => 'Your vote has been cancelled.'
	end
end
