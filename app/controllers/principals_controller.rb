class PrincipalsController < ApplicationController
  def index
	if params[:chamber_id]
		@chamber = Chamber.find(params[:chamber_id])
		@principals = @chamber.principals
	else
		@principals = Principal.all
	end
  end

  def show
    @principal = Principal.find(params[:id])
  end

  def new
    @principal = Principal.new
  end

  def create
    @principal = Principal.new(params[:principal])
    if @principal.save
      redirect_to @principal, :notice => "Successfully created principal."
    else
      render :action => 'new'
    end
  end

  def edit
    @principal = Principal.find(params[:id])
  end

  def update
    @principal = Principal.find(params[:id])
    if @principal.update_attributes(params[:principal])
      redirect_to @principal, :notice  => "Successfully updated principal."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @principal = Principal.find(params[:id])
    @principal.destroy
    redirect_to principals_url, :notice => "Successfully destroyed principal."
  end
  
  def matrix
	@principals = Principal.all
	@chambers = Chamber.all
  end
end
