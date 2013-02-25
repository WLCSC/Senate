class TagController < ApplicationController
  def tag
		@item = params[:model].constantize.find(params[:id])
		@item.tag_list.add(params[:tag])
		@item.save
		redirect_to [@item.chamber, @item]
  end

  def untag
		@item = params[:model].constantize.find(params[:id])
		@item.tag_list.remove(params[:tag])
		@item.save
		redirect_to [@item.chamber, @item]
  end

  def tagged
		@collection = []
		[Event, Ballot, Board, Proposal].each do |klass|
			@collection += klass.tagged_with(params[:tag])
		end
  end
end
