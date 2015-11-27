class AddListingIdToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :listing, index: true, foreign_key: true
  end
end
