class ListingsController < ApplicationController

	def index
		@listings = Listing.all
	end

	def new
		@listing = Listing.new
	end

	def create
		Listing.create(listing_params)
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
