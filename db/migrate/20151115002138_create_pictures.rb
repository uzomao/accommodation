class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.belongs_to :listing, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
