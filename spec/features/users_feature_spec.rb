require 'rails_helper'

feature "User can sign in and out" do
	context "user not signed in and on the homepage" do
		scenario "should see a 'sign in' link and a 'sign up' link" do
			visit('/')
			expect(page).to have_content('Sign In')
			expect(page).to have_content('Create Account')
		end

		scenario "should not see 'log out' link" do
      		visit('/')
      		expect(page).not_to have_link('Log out')
   		end
 	end

 	context "user signed in on the homepage" do
	    scenario "should see 'log out' link" do
	      visit('/')
	      sign_up
	      expect(page).to have_link('Log out')
    	end
    end
end

feature 'Users Profile Page' do 
	scenario 'users can visit their profile page and see their information' do 
		sign_up
		visit '/'
		click_link 'Profile'
		expect(page).to have_content("test@example.com")
		expect(page).to have_content("Jack Daniel")
	end

	scenario 'users can view listings they posted on their profile page' do
		sign_up
		create_listing
		click_link 'Profile'
		expect(page).to have_content("1 Posted")
		expect(page).to have_content("Listings Posted By Jack Daniel")
		expect(page).to have_content("The Student Centre")
	end

	scenario 'users can view listings they favourited on their profile page' do
		sign_up
		create_listing
		click_link 'Log out'
		sign_up("James", "Bond", "james@bond.com", "jamesbond")
		click_link 'Add to Favourites'
		click_link 'Profile'
		click_link '1 Favourites'
		expect(page).to have_content("Listings Favourited By James Bond")
		expect(page).to have_content("The Student Centre")
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
