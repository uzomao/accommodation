require 'rails_helper'

feature 'listings' do
	context 'no listings posted yet' do
		scenario 'should display a prompt to post listing' do
			visit '/listings'
			expect(page).to have_content('No listings have been posted yet')
			expect(page).to have_link('Add a listing')
		end
	end

	scenario 'Students can see a list of available accommodation' do
		Listing.create(name: "The Student Centre", address: "123 Douala Drive", city: "Yaounde", price: 145000)
		visit '/listings'
		expect(page).to have_content("The Student Centre")
	end
end