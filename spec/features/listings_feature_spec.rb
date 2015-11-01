require 'rails_helper'

feature 'listings' do
	before(:each) do
		sign_up
	end

	context 'no listings posted yet' do
		scenario 'should display a prompt to post listing' do
			visit '/listings'
			expect(page).to have_content('No listings have been posted yet')
			expect(page).to have_link('Add a listing')
		end
	end

	context 'listings have been posted / Viewing listings' do
		xscenario 'Users can see a list of available accommodation' do
			create_listing
			visit '/listings'
			expect(page).to have_content("The Student Centre")
		end

		xscenario 'Individual listings can be viewed in detail' do 
			create_listing
			visit '/'
			find('.thumbnail').click
			expect(page).to have_content("The Student Centre")
		end

	end

	context 'Creating Listings' do
		xscenario 'prompts landlord to fill out a form, then displays new listing' do 
			click_link 'Add a listing'
			fill_in 'Name', with: 'The Student Centre'
			fill_in 'Address', with: '123 Douala Drive'
			fill_in 'City', with: 'Yaounde'
			fill_in 'Price', with: 145000
			click_button 'Create Listing'
			expect(page).to have_content "The Student Centre"
			expect(current_path).to eq '/listings'
		end

		xscenario "landlord can only create listings if signed in" do
			visit '/'
			click_link 'Sign out'
			click_link 'Add a listing'
			expect(current_path).to eq '/users/sign_in'
		end

		xscenario 'landlord can edit listing' do
			create_listing
			visit '/listings'
			click_link 'Edit'
			fill_in 'Name', with: "The Student Place"
			click_button 'Update Listing'
			expect(page).to have_content 'The Student Place'
			expect(current_path).to eq '/listings'
		end

		xscenario 'listings can only be edited by the landlord that created them' do
			click_link 'Add a listing'
			fill_in 'Name', with: 'The Student Centre'
			fill_in 'Address', with: '123 Douala Drive'
			fill_in 'City', with: 'Yaounde'
			fill_in 'Price', with: 145000
			click_button 'Create Listing'
			visit '/'
			expect(page).to have_link 'Edit'
			click_link('Sign out')

			sign_up("email2@example.com", "testtest2")
		    expect(page).not_to have_link 'Edit'
		end
	end

	context 'Deleting listings' do
		xscenario 'Landlord can delete listings' do 
			create_listing
			visit '/listings'
			expect(page).to have_content("The Student Centre")
			click_link 'Delete'
			expect(page).not_to have_content("The Student Centre")
			expect(page).to have_content('No listings have been posted yet')
		end

		xscenario 'listings can only be deleted by the landlord that created them' do
		end
	end

	def sign_up(email="test@example.com", password="testtest")
		visit('/')
	    click_link('Sign up')
	    fill_in('Email', with: email)
	    fill_in('Password', with: password)
	    fill_in('Password confirmation', with: password)
	    click_button('Sign up')
	end

	def create_listing
		Listing.create(name: "The Student Centre", address: "123 Douala Drive", city: "Yaounde", price: 145000, user_id: 1)
	end

end