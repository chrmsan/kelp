require 'rails_helper'

feature 'restaurants' do

	context 'no restaurants have been added ' do
		scenario 'should display a ' do
			visit '/restaurants'
			expect(page).to have_content 'No restaurants yet'
			expect(page).to have_link 'Add a restaurant'
		end
	end

	context 'restaurants have been added' do
		before do
			Restaurant.create(name: 'Tratoria Populare')
		end

		scenario 'display restaurant' do
			visit '/restaurants'
			expect(page).to have_content 'Tratoria Populare'
			expect(page).not_to have_content 'No restaurants yet'
		end
	end

	context 'adding a restaurant' do 
		scenario 'user adds a new restaurant and the restaurant is displayed on the page' do
			visit '/restaurants'
			click_link 'Add a restaurant'
			fill_in :name, with: "McDonald's"
			click_button 'Add Restaurant'
			expect(page).to have_content "McDonald's"
			expect(current_path).to eq '/restaurants'
		end
	end

	context 'displaying an individual restaurant' do
		let!(:trat){Restaurant.create(name: 'Tratoria Populare')}
		scenario 'lets the user view a restaurant' do
			visit '/restaurants'
			click_link 'Tratoria Populare'
			expect(page).to have_content 'Tratoria Populare'
			expect(current_path).to eq "/restaurants/#{trat.id}"
		end
	end

	context 'user add description to restaurant' do
		scenario 'user adds a new restaurant and description' do
			visit '/restaurants'
			click_link 'Add a restaurant'
			fill_in :name, with: "Illegal Burger"
			fill_in :description, with: "Oslo's best burger joint ever!"
			click_button 'Add Restaurant'
			click_link 'Illegal Burger'
			expect(page).to have_content "Oslo's best burger joint ever!"
		end
	end

	context 'editing a restaurant' do
		let!(:trat){Restaurant.create(name: 'Tratoria Populare')}
		scenario 'lets user edit restuarant' do
			visit '/restaurants'
			click_link 'Tratoria Populare'
			click_link 'edit'
			fill_in :name, with: 'trat'
			click_button 'Update Restaurant'
			expect(page).to have_content 'trat'
			expect(page).not_to have_content 'Tratoria Populare'
		end
	end

	context 'deleting a restaurant' do
		let!(:medi){Restaurant.create(name: 'Mediterranean Grill')}
		scenario 'lets user delete restuarant' do
			visit '/restaurants'
			click_link 'Mediterranean Grill'
			click_link 'delete'
			expect(page).not_to have_content 'Mediterranean Grill'
			expect(page).to have_content 'Restaurant deleted successfully'
		end
	end

	context 'an invalid restaurant' do
		scenario 'does not let you submit a name that is too short' do
			visit '/restaurants'
			click_link 'Add a restaurant'
			fill_in :name, with: 'kf'
			click_button 'Add Restaurant'
			expect(page).not_to have_css 'h2', text: 'kf'
			expect(page).to have_content 'error'
		end
	end

end