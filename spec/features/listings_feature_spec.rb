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
		scenario 'Users can see a list of available accommodation' do
			create_listing
			visit '/listings'
			expect(page).to have_content("The Student Centre")
		end

		scenario 'Individual listings can be viewed in detail' do 
			create_listing
			visit '/'
			find('.thumbnail').click
			expect(page).to have_content("The Student Centre")
		end

	end

	context 'Creating Listings' do
		scenario 'prompts landlord to fill out a form, then displays new listing' do 
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
			click_link 'Log out'
			click_link 'Add a listing'
			expect(current_path).to eq '/users/sign_in'
		end

		scenario 'landlord can edit listing' do
			create_listing
			visit '/listings'
			click_link 'Edit'
			fill_in 'Name', with: "The Student Place"
			click_button 'Update Listing'
			expect(page).to have_content 'The Student Place'
			expect(current_path).to eq '/listings'
		end

		scenario 'listings can only be edited by the landlord that created them' do
			click_link 'Add a listing'
			fill_in 'Name', with: 'The Student Centre'
			fill_in 'Address', with: '123 Douala Drive'
			fill_in 'City', with: 'Yaounde'
			fill_in 'Price', with: 145000
			click_button 'Create Listing'
			visit '/'
			expect(page).to have_link 'Edit'
			click_link('Log out')

			sign_up("email2@example.com", "testtest2")
		    expect(page).not_to have_link 'Edit'
		end
	end

	context 'Deleting listings' do
		scenario 'Landlord can delete listings' do 
			create_listing
			visit '/listings'
			expect(page).to have_content("The Student Centre")
			click_link 'Delete'
			expect(page).not_to have_content("The Student Centre")
			expect(page).to have_content('No listings have been posted yet')
		end

		scenario 'listings can only be deleted by the landlord that created them' do
		end
	end

	context 'Favourites' do
		scenario 'Listing can be favourited' do
			create_listing
			click_link('Log out')
			sign_up("James", "Bond", "james@bond.com", "jamesbond")
			click_link("Add to Favourites")
			expect(page).to have_link("Remove from Favourites")
		end

		scenario 'Listing can be removed from favourites' do
			create_listing
			click_link('Log out')
			sign_up("James", "Bond", "james@bond.com", "jamesbond")
			click_link("Add to Favourites")
			click_link("Remove from Favourites")
			expect(page).to have_link("Add to Favourites")
		end
	end

	context "Images" do
		scenario "Users can add images to listings" do
			click_link 'Add a listing'
			fill_in 'Name', with: 'The Student Centre'
			fill_in 'Address', with: '123 Douala Drive'
			fill_in 'City', with: 'Yaounde'
			fill_in 'Price', with: 145000
			save_and_open_page
			click_button "Upload images"
			click_button 'Create Listing'
			visit '/'
			expect(page).to have_xpath('//img')
		end
	end

	def sign_up(first_name="Jack", last_name="Daniel", email="test@example.com", password="testtest")
		visit('/')
		within('#register') do
			fill_in('First Name', with: first_name)
			fill_in('Last Name', with: last_name)
		    fill_in('Email', with: email)
		    fill_in('Confirm Email', with: email)
		    fill_in('Password', with: password)
		    fill_in('Confirm Password', with: password)
		    click_button('Register')
		end
	end

	def create_listing
		current_user_id = User.first.id
		Listing.create(name: "The Student Centre", address: "123 Douala Drive", city: "Yaounde", price: 145000, user_id: current_user_id)
	end

end