feature 'reviews' do
	context 'user add review to restaurant' do
		before {Restaurant.create(name: "KFC")}
		
		scenario 'user adds a review to an existing restaurant' do
			visit '/restaurants'
			click_link 'Review KFC'
			fill_in 'Thoughts', with: "Finger lickin' good"
			select '3', from: 'Rating'
			click_button 'Leave Review'
			expect(current_path).to eq "/restaurants"		
			expect(page).to have_content("Finger lickin' good")
		end
	end
end