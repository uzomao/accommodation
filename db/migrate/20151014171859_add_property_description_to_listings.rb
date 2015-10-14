class AddPropertyDescriptionToListings < ActiveRecord::Migration
  def change
    add_column :listings, :prop_desc, :string
    add_column :listings, :text, :string
  end
end
