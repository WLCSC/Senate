class CommentsController < ApplicationController
before_filter :find_chamber
layout "chambers"

def find_chamber
	if params[:chamber_id]
		@chamber = Chamber.find params[:chamber_id]
	end
end	
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
	@chamber = @comment.commentable.chamber
	#redirect_to @comment.commentable
  end

  def new
    @comment = Comment.new
	@comment.commentable = params[:commentable_type], params[:commentable_id]
  end

  def create
    @comment = Comment.new(params[:comment])
	@comment.user_id = current_user.id
    if @comment.save
      redirect_to @comment, :notice => "Successfully created comment."
    else
      render :action => 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to @comment, :notice  => "Successfully updated comment."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
	@parent = @comment.commentable
	@chamber = @comment.commentable.chamber
    @comment.destroy
    redirect_to @parent, :notice => "Successfully destroyed comment."
  end
end
