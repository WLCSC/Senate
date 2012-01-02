class ChambersController < ApplicationController
	layout "chambers"
  def index
    @chambers = Chamber.all
	render :layout => 'application'
  end

  def show
    @chamber = Chamber.find(params[:id])
	@news = @chamber.announcements.last(2)
  end

  def new
    @chamber = Chamber.new
	render :layout => 'application'
  end

  def create
    @chamber = Chamber.new(params[:chamber])

    if @chamber.save
	p = Permission.new
	p.priority = '0'
	p.chamber = @chamber
	p.principal = current_user.principal
	p.administratable = true
	p.save
      redirect_to @chamber, :notice => "Successfully created chamber."
    else
      render :action => 'new'
    end
  end

  def edit
    @chamber = Chamber.find(params[:id])
  end

  def update
    @chamber = Chamber.find(params[:id])
    if @chamber.update_attributes(params[:chamber])
      redirect_to @chamber, :notice  => "Successfully updated chamber."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @chamber = Chamber.find(params[:id])
    @chamber.destroy
    redirect_to chambers_url, :notice => "Successfully destroyed chamber."
  end
end
