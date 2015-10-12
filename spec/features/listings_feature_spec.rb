require 'rails_helper'

feature 'listings' do
	context 'no listings posted yet' do
		scenario 'should display a prompt to post listing' do
			visit '/listings'
			expect(page).to have_content('No listings have been posted yet')
			expect(page).to have_link('Add a listing')
		end
	end

	context 'listings have been posted' do
		scenario 'Students can see a list of available accommodation' do
			Listing.create(name: "The Student Centre", address: "123 Douala Drive", city: "Yaounde", price: 145000)
			visit '/listings'
			expect(page).to have_content("The Student Centre")
		end
	end

	context 'Creating Listings' do
		scenario 'prompts landlord to fill out a form, then displays new listing' do 
			visit('/')
		    click_link('Sign up')
		    fill_in('Email', with: 'test@example.com')
		    fill_in('Password', with: 'testtest')
		    fill_in('Password confirmation', with: 'testtest')
		    click_button('Sign up') #move these into helper method
			click_link 'Add a listing'
			fill_in 'Name', with: 'The Student Centre'
			fill_in 'Address', with: '123 Douala Drive'
			fill_in 'City', with: 'Yaounde'
			fill_in 'Price', with: 145000
			click_button 'Create Listing'
			expect(page).to have_content "The Student Centre"
			expect(current_path).to eq '/listings'
		end

		scenario "landlord can only create listings if signed in" do
			visit '/'
			click_link 'Add a listing'
			expect(current_path).to eq '/users/sign_in'
		end

		scenario 'landlord can edit listing' do
			Listing.create(name: "The Student Centre", address: "123 Douala Drive", city: "Yaounde", price: 145000)
			visit '/listings'
			click_link 'Edit'
			fill_in 'Name', with: "The Student Place"
			click_button 'Update Listing'
			expect(page).to have_content 'The Student Place'
			expect(current_path).to eq '/listings'
		end
	end

	context 'Deleting listings' do
		scenario 'Landlord can delete listings' do 
			Listing.create(name: "The Student Centre", address: "123 Douala Drive", city: "Yaounde", price: 145000)
			visit '/listings'
			expect(page).to have_content("The Student Centre")
			click_link 'Delete'
			expect(page).not_to have_content("The Student Centre")
			expect(page).to have_content('No listings have been posted yet')
		end
	end
end