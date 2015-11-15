class ListingsController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :show]

	def index
		@listings = Listing.all
	end

	def new
		@listing = Listing.new
	end

	def create
		@listing = current_user.listings.new(listing_params)
		
		if @listing.save
     
	      	if params[:images]
	        	params[:images].each do |image|
	            	@listing.pictures.create(image: image)
	            end
	        end
	        flash[:notice] = "An error has occurred with creating your listing"
    	else
            
        end
		redirect_to '/listings'
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def show
		@listing = Listing.find(params[:id])
		@listing_owner = User.find(@listing.user_id)
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
    	params.require(:listing).permit(:name, :address, :city, :price, :prop_desc, :prop_info)
  	end
	
end
