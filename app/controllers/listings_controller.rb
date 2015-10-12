class ListingsController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :show]

	def index
		@listings = Listing.all
	end

	def new
		@listing = Listing.new
	end

	def create
		Listing.create(listing_params)
		Listing.last.update_columns(user_id: current_user.id)
		redirect_to '/listings'
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		@listing.update(listing_params)
		flash[:notice] = "Listing edited successfully"
		redirect_to '/listings'
	end

	def destroy
		@listing = Listing.find(params[:id])
		@listing.destroy
		flash[:notice] = "Your listing has been deleted successfully"
		redirect_to '/listings'
	end

	def listing_params
    	params.require(:listing).permit(:name, :address, :city, :price)
  	end
	
end
