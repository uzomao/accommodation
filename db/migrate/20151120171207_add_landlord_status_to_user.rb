class AddLandlordStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_landlord, :boolean
  end
end
