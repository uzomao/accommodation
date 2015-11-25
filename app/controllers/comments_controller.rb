class CommentsController < ApplicationController

	def new
        @listing = Listing.find(params[:listing_id])
  		@comment = Comment.new
	end

	def create
  		@listing = Listing.find(params[:listing_id])
  		@listing.comments.create(comment_params)
  		Comment.last.update_columns(user_id: current_user.id)
  		redirect_to listing_path(@listing.id)
	end

	def comment_params
  		params.require(:comment).permit(:thoughts)
	end

end
