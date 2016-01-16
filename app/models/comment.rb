class Comment < ActiveRecord::Base
	belongs_to :restaurant
	belongs_to :user

	acts_as_tree order: 'created_at DESC'
end
