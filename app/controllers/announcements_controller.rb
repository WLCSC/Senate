class AnnouncementsController < ApplicationController
before_filter :find_chamber
layout "chambers"

def find_chamber
	if params[:chamber_id]
		@chamber = Chamber.find params[:chamber_id]
	end
end	
  def index
    @announcements = Announcement.all
  end

  def show
    @announcement = Announcement.find(params[:id])
	@chamber = @announcement.chamber
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(params[:announcement])
	@announcement.user = current_user
    if @announcement.save
      redirect_to @announcement, :notice => "Successfully created announcement."
    else
      render :action => 'new'
    end
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def update
    @announcement = Announcement.find(params[:id])
    if @announcement.update_attributes(params[:announcement])
      redirect_to @announcement, :notice  => "Successfully updated announcement."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @announcement = Announcement.find(params[:id])
	@chamber = @announcement.chamber
    @announcement.destroy
    redirect_to @chamber, :notice => "Successfully destroyed announcement."
  end  	
end
