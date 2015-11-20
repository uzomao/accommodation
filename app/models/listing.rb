class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :favourites, dependent: :destroy

	has_many :pictures, dependent: :destroy

	def self.search(query)
	    where("name like ?", "%#{query}%") 
  	end

end
