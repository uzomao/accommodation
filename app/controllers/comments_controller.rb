class CommentsController < ApplicationController

	def new
        @listing = Listing.find(params[:restaurant_id])
  		@comment = Comment.new
	end

	def create
  		@listing = Listing.find(params[:restaurant_id])
  		@listing.comments.create(comment_params)
  		redirect_to listings_path
	end

	def comment_params
  		params.require(:comment).permit(:thoughts)
	end

end
