# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# clean listings from database
Listing.destroy_all
User.destroy_all
Picture.destroy_all

def seed_image(file_name)
  File.open(File.join(Rails.root, "/app/assets/images/seed/#{file_name}.jpg"))
end




user = User.new(email: "jack@mail.com", first_name: "Jack", last_name: "Jansang", password: "1234567890", encrypted_password: "1234567890")
user.save!
listing1 = Listing.create!(name: "Hotel Lunde", address: "123 Douala Road", city: "Douala", price: 4000, user_id: user.id)
image1 = Picture.create({
  image: File.new(File.join(Rails.root, "/app/assets/images/seed/1.jpg")),
  # image: "https://s3.amazonaws.com/camacco-bucket/1.jpg",
  listing_id: listing1.id
})
listing2 = Listing.create!(name: "Yaounde Apartment", address: "6435 Yaounde Road", city: "Yaounde", price: 3000, user_id: user.id)
image2 = Picture.create({
  # image: File.new(File.join(Rails.root, "/app/assets/images/seed/2.jpg")),
  image: "https://s3.amazonaws.com/camacco-bucket/2.jpg",
  listing_id: listing2.id
})
listing3 = Listing.create!(name: "Garoua Apartment", address: "123 Garoua Road", city: "Garoua", price: 1200, user_id: user.id)
image3 = Picture.create({
  # image: File.new(File.join(Rails.root, "/app/assets/images/seed/3.jpg")),
  image: "https://s3.amazonaws.com/camacco-bucket/3.jpg",
  listing_id: listing3.id
})
listing4 = Listing.create!(name: "Maroua Apartment", address: "123 Maroua Road", city: "Maroua", price: 1800, user_id: user.id)
image4 = Picture.create({
  # image: File.new(File.join(Rails.root, "/app/assets/images/seed/4.jpg")),
  image: "https://s3.amazonaws.com/camacco-bucket/4.jpg",
  listing_id: listing4.id
})
listing5 = Listing.create!(name: "Foumban Apartment", address: "123 Foumban Road", city: "Foumban", price: 3200, user_id: user.id)
image5 = Picture.create({
  # image: File.new(File.join(Rails.root, "/app/assets/images/seed/5.jpg")),
  image: "https://s3.amazonaws.com/camacco-bucket/5.jpg",
  listing_id: listing5.id
})
listing6 = Listing.create!(name: "Kribi Apartment", address: "123 Kribi Road", city: "Kribi", price: 2000, user_id: user.id)
image6 = Picture.create({
  # image: File.new(File.join(Rails.root, "/app/assets/images/seed/6.jpg")),
  image: "https://s3.amazonaws.com/camacco-bucket/6.jpg",
  listing_id: listing6.id
})
listing7 = Listing.create!(name: "Bonapriso Apartment", address: "123 Bonapriso Road", city: "Apartment", price: 1000, user_id: user.id)
image7 = Picture.create({
  image: "https://s3.amazonaws.com/camacco-bucket/7.jpg",
  listing_id: listing7.id
})
listing8 = Listing.create!(name: "Kake Apartment", address: "123 Kake Road", city: "Kake", price: 1500, user_id: user.id)
image8 = Picture.create({
  image: "https://s3.amazonaws.com/camacco-bucket/8.jpg",
  listing_id: listing8.id
})
listing9 = Listing.create!(name: "Mamfe Apartment", address: "123 Mamfe Road", city: "Mamfe", price: 2500, user_id: user.id)
image9 = Picture.create({
  image: "https://s3.amazonaws.com/camacco-bucket/9.jpg",
  listing_id: listing9.id
})
listing10 = Listing.create!(name: "Limbe Apartment", address: "123 Limbe Road", city: "Limbe", price: 3000, user_id: user.id)
image1 = Picture.create({
  # image: File.new(File.join(Rails.root, "/app/assets/images/seed/10.jpg")),
  image: "https://s3.amazonaws.com/camacco-bucket/10.jpg",
  listing_id: listing10.id
})
