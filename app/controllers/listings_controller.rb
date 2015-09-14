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

	def listing_params
    	params.require(:listing).permit(:name, :address, :city, :price)
  	end
	
end
