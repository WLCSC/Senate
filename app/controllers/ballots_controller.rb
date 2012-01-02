class BallotsController < ApplicationController
before_filter :find_chamber
layout "chambers"

def find_chamber
	if params[:chamber_id]
		@chamber = Chamber.find params[:chamber_id]
	end
end	
  def index
    @ballots = Ballot.all
  end

  def show
    @ballot = Ballot.find(params[:id])
  end

  def new
    @ballot = Ballot.new
  end

  def create
    @ballot = Ballot.new(params[:ballot])
	i=0
	@ballot.options = @ballot.options_raw.split("\n").map{|x| i+=1;[i,x] }.to_yaml
    if @ballot.save
      redirect_to @ballot, :notice => "Successfully created ballot."
    else
      render :action => 'new'
    end
  end

  def edit
    @ballot = Ballot.find(params[:id])
	@ballot.options_raw = YAML.load(@ballot.options).map{|x| x[1]}.join("\n")
  end

  def update
    @ballot = Ballot.find(params[:id])
	i=0
	@ballot.options = params[:ballot][:options_raw].split("\n").map{|x| i+=1;[i,x] }.to_yaml
    if @ballot.update_attributes(params[:ballot])
      redirect_to @ballot, :notice  => "Successfully updated ballot."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @ballot = Ballot.find(params[:id])
    @ballot.destroy
    redirect_to ballots_url, :notice => "Successfully destroyed ballot."
  end
  
  def close
	@ballot = Ballot.find(params[:id])
	@ballot.closed = false
	@ballot.save
	totals = {}
	@ballot.remarks.each do |remark|
		totals[remark.remark] ? totals[remark.remark] += 1 : totals[remark.remark] = 1
	end
	totals = totals.sort{|a,b| b[1] <=> a[1]}
	options = YAML.load(@ballot.options).map{|x| x[1]}
	winner = options[totals[0][0]-1]
	
	flash[:notice] = "Ballot closed."
	@ballot.chamber.announce("Ballot ##{@ballot.id}, #{@ballot.name}, has been closed.  The option with the most votes was #{winner}.",current_user)
	
	redirect_to @ballot
  end
end
