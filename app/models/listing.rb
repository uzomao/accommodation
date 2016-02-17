class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :favourites, dependent: :destroy

	has_many :pictures, dependent: :destroy

	has_many :comments, dependent: :destroy

	def self.search(name, min_price, max_price, city)
	    where("name like ? and price > ? and price < ? and city like ?", "%#{name}%", min_price, max_price, "%#{city}") 
  	end

  	def paypal_url(return_path)
	    values = {
	        business: "chidumaga@gmail.com",
	        cmd: "_xclick",
	        upload: 1,
	        return: "#{Rails.application.secrets.app_host}#{return_path}",
	        invoice: id,
	        amount: self.price,
	        item_name: self.name,
	        item_number: self.id,
	        quantity: '1'
	    }
	    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  	end

end
