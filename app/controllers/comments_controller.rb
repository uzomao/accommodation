class CommentsController < ApplicationController

	def new
      @listing = Listing.find(params[:listing_id])
  		@comment = Comment.new(parent_id: params[:parent_id])
	end

	def create
      if params[:comment][:parent_id].to_i > 0
        parent = Comment.find_by_id(params[:comment].delete(:parent_id))
        @comment = parent.children.build(comment_params)
      else
  		@listing = Listing.find(params[:listing_id])
  		@listing.comments.create(comment_params)
  		Comment.last.update_columns(user_id: current_user.id)
      flash[:success] = 'Your comment was successfully added!'
  		redirect_to listing_path(@listing.id)
	end

	def comment_params
  		params.require(:comment).permit(:thoughts)
	end

end
