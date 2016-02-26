class ListingsController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :show]
	protect_from_forgery except: [:hook]

	def index
		if params[:search]
      		@listings = Listing.search(params[:search], params[:min_price], params[:max_price], params[:city]).order("created_at DESC")
      		if @listings.count == 0
	      		@search_results_returned = "No properties found. Please try widening your search."

	      	else
	      		@search_results_returned = "#{@listings.count} properties found with your search."
      		end
      		
    	else
			@listings = Listing.all
		end
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
    	else
          flash[:notice] = "An error has occurred with creating your listing"
    	end

		redirect_to '/listings'
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def show
		@listing = Listing.find(params[:id])
		@listing_owner = User.find(@listing.user_id)
		@comment = Comment.new

		if Conversation.between(@listing.user_id, current_user.id).present?
      @conversation = Conversation.between(@listing.user_id, current_user.id).first
    else
      @conversation = Conversation.create!(@listing.user_id, current_user.id)
    end

    p @conversation

	end

	def update
		@listing = Listing.find(params[:id])
		@listing.update(listing_params)
		if params[:images]
        	params[:images].each do |image|
            	@listing.pictures.create(image: image)
          	end
	    end
		flash[:notice] = "Listing edited successfully"
		redirect_to '/'
	end

	def destroy
		@listing = Listing.find(params[:id])
		@listing.destroy
		flash[:notice] = "Your listing has been deleted successfully"
		redirect_to '/'
	end

	def activate_paypal
		@listing = Listing.find(params[:format])
		redirect_to @listing.paypal_url(listing_path(@listing))
	end

	def hook
		params.permit! # Permit all Paypal input params
		status = params[:payment_status]
		if status == "Completed"
		  @payment = Payment.find params[:invoice]
		  @payment.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
		end
		render nothing: true
	end

	def listing_params
    	params.require(:listing).permit(:name, :address, :city, :price, :prop_desc, :prop_info)
  	end
	
end