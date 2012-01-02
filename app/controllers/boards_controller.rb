class BoardsController < ApplicationController
before_filter :find_chamber
layout "chambers"

def find_chamber
	if params[:chamber_id]
		@chamber = Chamber.find params[:chamber_id]
	end
end	
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
	@chamber = @board.chamber
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(params[:board])
    if @board.save
      redirect_to @board, :notice => "Successfully created board."
    else
      render :action => 'new'
    end
  end

  def edit
    @board = Board.find(params[:id])
	@chamber = @board.chamber
  end

  def update
    @board = Board.find(params[:id])
    if @board.update_attributes(params[:board])
      redirect_to @board, :notice  => "Successfully updated board."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to boards_url, :notice => "Successfully destroyed board."
  end
end
