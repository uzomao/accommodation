class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :favourites, dependent: :destroy

	has_many :pictures, dependent: :destroy
end
