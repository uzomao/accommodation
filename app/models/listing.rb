class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :favourites, dependent: :destroy
end
