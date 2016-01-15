class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :favourites, dependent: :destroy

	has_many :pictures, dependent: :destroy

	has_many :comments, dependent: :destroy

	def self.search(name, min_price, max_price, city)
	    where("name like ? and price > ? and price < ? and city like ?", "%#{name}%", min_price, max_price, "%#{city}") 
  	end

end
