require 'rails_helper'

feature 'restaurants' do

  context 'no restauranrs have been added' do
    scenario 'shuold display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'NOOO RESTAURANTS EVER!!!'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Dandos')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'Dandos'
      expect(page).not_to have_content 'NOOO RESTAURANTS EVER!!!'
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing restaurants' do

    let!(:kfc){ Restaurant.create(name:'KFC') }

    scenario 'lets a user view a restaurant' do
     visit '/restaurants'
     click_link 'KFC'
     expect(page).to have_content 'KFC'
     expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before { Restaurant.create name: 'Nandos', description: 'grilled chicken' }

    scenario 'let user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit Nandos'
      fill_in 'Name', with: 'Nandooos'
      fill_in 'Description', with: 'grilled cat'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Nandooos'
      expect(page).to have_content 'grilled cat'
      expect(current_path).to eq '/restaurants'
    end
  end



end