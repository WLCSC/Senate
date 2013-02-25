class CommentsController < ApplicationController
	before_filter :check_for_user
	def show
		@comment = Comment.find(params[:id])
		@chamber = @comment.commentable.chamber
	end
	def create
		@comment = Comment.new(params[:comment])
		if @comment.save
			Log.create(:user => current_user, :chamber => @comment.commentable.chamber, :action_type => "Comment", :action_id => @comment.id, :comment => "commented on a #{@comment.superparent.class.to_s.downcase}.")
			redirect_to [@comment.commentable.chamber, @comment.commentable], :notice => "Successfully created comment."
		else
			redirect_to [@comment.commentable.chamber, @comment.commentable], :error => "Could not create comment."
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		if @comment
		@parent = @comment.commentable
		@comment.delete
		redirect_to [@parent.chamber, @parent], info: "Comment removed."
		else
			redirect_to session[:return_to], :notice => "Comment was already deleted."
		end
	end
end
