class AddPropertyInfoToListings < ActiveRecord::Migration
  def change
    add_column :listings, :prop_info, :text
  end
end
