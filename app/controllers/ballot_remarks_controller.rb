class BallotRemarksController < ApplicationController
before_filter :find_chamber
layout "chambers"

def find_chamber
	if params[:chamber_id]
		@chamber = Chamber.find params[:chamber_id]
	end
end	
  def index
    @ballot_remarks = BallotRemark.all
	if params[:ballot_id]
		@ballot = Ballot.find params[:ballot_id]
		if @ballot.anonymous
			redirect_to @ballot, :error => "You can't look at the records of anonymous ballots."
		end
		o = YAML.load(@ballot.options)
		@options = {}
		o.each do |x|
			@options[x[0]] = (x[1]==true ? "Yes" : x[1])
		end
	end
  end

  def show
    @ballot_remark = BallotRemark.find(params[:id])
  end

  def new
    @ballot_remark = BallotRemark.new
  end

  def create
    @ballot_remark = BallotRemark.new(params[:ballot_remark])
    if @ballot_remark.save
      redirect_to @ballot_remark.ballot, :notice => "Successfully created ballot remark."
    else
      render :action => 'new'
    end
  end

  def edit
    @ballot_remark = BallotRemark.find(params[:id])
  end

  def update
    @ballot_remark = BallotRemark.find(params[:id])
    if @ballot_remark.update_attributes(params[:ballot_remark])
      redirect_to @ballot_remark.ballot, :notice  => "Successfully updated ballot remark."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @ballot_remark = BallotRemark.find(params[:id])
	@ballot = @ballot_remark.ballot
    @ballot_remark.destroy
    redirect_to @ballot, :notice => "Successfully destroyed ballot remark."
  end
end
