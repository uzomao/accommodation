# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# clean listings from database
Listing.delete_all
# User.delete_all
Picture.delete_all

def seed_image(file_name)
  File.open(File.join(Rails.root, "/app/assets/images/seed/#{file_name}.jpg"))
end




user = User.create(email: "jack@mail.com", first_name: "Jack", last_name: "Jansang", encrypted_password: "1234567890")
listing = Listing.create!(name: "Hotel Lunde", address: "123 Douala Road", city: "Douala", price: 3000, user_id: user.id)
image1 = Picture.create({
  # :id => 52, 
  # asset: File.new("#{Rails.root}/path/to/somefile.jpg"),
  image: File.new(File.join(Rails.root, "/app/assets/images/seed/frog.jpg")),
  listing_id: listing.id
})