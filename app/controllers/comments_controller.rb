class CommentsController < ApplicationController

	def new
      @listing = Listing.find(params[:listing_id])
  		@comment = Comment.new(parent_id: params[:parent_id])
	end

	def create
    @listing = Listing.find(params[:listing_id])

    if params[:comment][:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:comment].delete(:parent_id))
      p parent
      @comment = parent.children.build(comment_params)
      p @comment
      success
    else
  		@listing.comments.create(comment_params)
  		Comment.last.update_columns(user_id: current_user.id)
      success
    end
  end


	def comment_params
  	params.require(:comment).permit(:thoughts)
	end

  def success
    flash[:success] = 'Your comment was successfully added!'
    redirect_to listing_path(@listing.id)
  end

end
