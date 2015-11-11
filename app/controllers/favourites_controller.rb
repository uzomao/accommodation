class FavouritesController < ApplicationController

	def create
		@listing = Listing.find(params[:listing_id])
		@listing.favourites.create

		current_user.favourites << @listing.id
		current_user.save!

		redirect_to(:back)
	end

	def destroy
		@listing = Listing.find(params[:listing_id])

		current_user.favourites.delete(@listing.id)
		current_user.save!

		redirect_to(:back)
	end

end
