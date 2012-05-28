class CommentsController < ApplicationController
	def show
		@comment = Comment.find(params[:id])
		@chamber = @comment.commentable.chamber
	end
	def create
		@comment = Comment.new(params[:comment])
		if @comment.save
			redirect_to [@comment.commentable.chamber, @comment.commentable], :notice => "Successfully created comment."
		else
			redirect_to [@comment.commentable.chamber, @comment.commentable], :error => "Could not create comment."
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@parent = @comment.commentable
		@comment.delete
		redirect_to [@parent.chamber, @parent], info: "Comment removed."
	end
end
